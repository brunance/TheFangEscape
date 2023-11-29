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
    
    public var torchComponent: TorchComponent? {
        return self.component(ofType: TorchComponent.self)
    }
    
    public var deathComponent: DeathComponent? {
        return self.component(ofType: DeathComponent.self)
    }
    
    public var winComponent: WinComponent? {
        return self.component(ofType: WinComponent.self)
    }
    
    public init(position: CGPoint = .zero) {
        super.init()
        
        self.addComponent(IsPlayerComponent())
        
        let animationStateMachine : GKStateMachine = .init(states: [
            Run(self, action: SKAction.playerRun()),
            Jump(self, action: SKAction.playerJump()),
            WallSlide(self, action: SKAction.playerWallSlide()),
            DeathByDark(self),
            DeathByTrap(self),
            Win(self)
        ])
        
        self.addComponent(AnimationStateMachineComponent(stateMachine: animationStateMachine))
        
        let node = SKSpriteNode(imageNamed: "run1")
        node.position = position
        self.addComponent(GKSKNodeComponent(node: node))
        
        let size: CGSize = .init(width: node.size.width/2, height: node.size.height - 4)
        let physicsComp = PhysicsComponent.capsule(size: size, cornerRadius: 10)
        physicsComp.body.allowsRotation = false
        physicsComp.body.restitution = 0.0
        physicsComp.body.categoryBitMask = .player
        physicsComp.body.friction = 0
        physicsComp.body.collisionBitMask = .contactWithAllCategories(less: [.enemy, .item])
        
        self.addComponent(physicsComp)
        
        self.addComponent(MovementComponent(velocityX: 100 * 4, direction: .right))
        self.addComponent(JumpComponent(forceY: 350, forceX: 150))
        self.addComponent(WallSlideComponent())
        
        self.addComponent(TorchComponent())
        
        self.addComponent(DestructableComponent())
        self.addComponent(DeathComponent())
        
        self.addComponent(WinComponent())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
