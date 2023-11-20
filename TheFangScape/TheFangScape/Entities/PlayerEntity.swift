//
//  PlayerEntity.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 13/11/23.
//

import Foundation
import GameplayKit
import SpriteKit

public class PlayerEntity: GKEntity {
    
    public var jumpComponent: JumpComponent? {
        return self.component(ofType: JumpComponent.self)
    }
    
    public init(position: CGPoint = .zero) {
        super.init()
        
        let animationStateMachine : GKStateMachine = .init(states: [
            Run(self),
            Jump(self),
            WallSlide(self),
            DeathByDark(self),
            DeathByTrap(self),
            Win(self)
        ])
        
        self.addComponent(AnimationStateMachineComponent(stateMachine: animationStateMachine))
        
        let node = SKSpriteNode(color: .blue, size: .init(width: 48, height: 48))
        node.position = position
        self.addComponent(GKSKNodeComponent(node: node))
        
        let physicsComp = PhysicsComponent.rectangleBody(ofSize: node.size)
        physicsComp.body.allowsRotation = false
        physicsComp.body.linearDamping = 0.5
        physicsComp.body.restitution = 0.0
        self.addComponent(physicsComp)
        
        self.addComponent(MovementComponent(velocityX: 32 * 8, direction: .right))
        self.addComponent(JumpComponent(forceY: 64, forceX: 32))
        self.addComponent(WallSlideComponent())
        
        self.addComponent(TorchComponent())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
