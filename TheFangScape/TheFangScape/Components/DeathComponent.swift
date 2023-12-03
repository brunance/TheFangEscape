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
        guard let stateMachine = stateComp?.stateMachine else {return}
        
        deathHasStarted = true
        entity?.component(ofType: PhysicsComponent.self)?.body.velocity.dx = 0
        entity?.component(ofType: MovementComponent.self)?.isDead = true
        
        switch deathType {
        case .dark:
            stateMachine.enter(DeathByDark.self)
        case .trap:
            stateMachine.enter(DeathByTrap.self)
        }
        
        let sequence = SKAction.sequence([.wait(forDuration: 0.14)])
       
        node?.run(sequence) { [weak self] in
            guard let entity = self?.entity else { return }
            entity.component(ofType: DestructableComponent.self)?.destroy()
        }
    }
}

