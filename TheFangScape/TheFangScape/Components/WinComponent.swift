//
//  WinComponent.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 24/11/23.
//

import Foundation
import GameplayKit

public class WinComponent: GKComponent {
    
    weak var stateComp: AnimationStateMachineComponent?
    weak var node: SKNode?
    
    public override func didAddToEntity() {
        node = entity?.component(ofType: GKSKNodeComponent.self)?.node
        stateComp = entity?.component(ofType: AnimationStateMachineComponent.self)
    }
    
    public func startWin() {
        guard let stateMachine = stateComp?.stateMachine else {return}
        
        entity?.removeComponent(ofType: MovementComponent.self)
        entity?.removeComponent(ofType: JumpComponent.self)
        
        stateMachine.enter(Win.self)
        
        let sequence = SKAction.sequence([.wait(forDuration: 1.5)])
       
        node?.run(sequence) { [weak self] in
            guard let entity = self?.entity else { return }
            entity.component(ofType: DestructableComponent.self)?.destroy()
        }
    }
}

