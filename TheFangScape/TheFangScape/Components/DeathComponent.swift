//
//  DeathComponent.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 21/11/23.
//

import Foundation
import GameplayKit

public enum DeathType {
    case dark, trap
}

public class DeathComponent: GKComponent {
    
    weak var stateComp: AnimationStateMachineComponent?
    weak var node: SKNode?
    public var deathHasStarted = false
    
    public override func didAddToEntity() {
        node = entity?.component(ofType: GKSKNodeComponent.self)?.node
        stateComp = entity?.component(ofType: AnimationStateMachineComponent.self)
    }
    
    public func startDeath(by deathType: DeathType) {
        guard let stateMachine = stateComp?.stateMachine, let entity = entity else {return}
        
        deathHasStarted = true
        
        entity.component(ofType: PhysicsComponent.self)?.stopMovement()
        entity.component(ofType: TorchComponent.self)?.restore()
        entity.component(ofType: MovementComponent.self)?.toggleDeath()
        
        switch deathType {
        case .dark:
            stateMachine.enter(DeathByDark.self)
        case .trap:
            stateMachine.enter(DeathByTrap.self)
        }
        
        let zoomAction = SKAction.scale(by: 1.5, duration: 1.0)
            
        let sequence = SKAction.sequence([
            .run {
                guard let scene = self.node?.scene as? GameScene else { return }
                let camera = scene.camera
                camera?.position = self.node?.position ?? CGPoint(x: 0, y: 0)
                let zoomAction = SKAction.scale(to: 0.5, duration: 0.8)
                camera?.run(zoomAction)
            },
            .wait(forDuration: 1.14)
        ])
           
        node?.run(sequence) { [weak self] in
            guard let entity = self?.entity, let scene = self?.node?.scene as? GameScene else { return }
            entity.component(ofType: DestructableComponent.self)?.destroy()
            entity.component(ofType: TorchComponent.self)?.removeVampireEyes()
            scene.restartLevel()
        }
    }
}

