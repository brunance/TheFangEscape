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
    
    public weak var node: SKNode? {
        return self.component(ofType: GKSKNodeComponent.self)?.node
    }
    
    public init(position: CGPoint = .zero) {
        super.init()
        
        self.addComponent(IsPlayerComponent())
        
        let animationStateMachine : GKStateMachine = .init(states: [
            RunningState(self, action: SKAction.playerRun()),
            JumpingState(self, action: SKAction.playerJump()),
            WallSlidingState(self, action: SKAction.playerWallSlide()),
            DeathByDark(self, action: SKAction.playerDeathByDark()),
            DeathByTrap(self, action: SKAction.playerDeathByTrap()),
            WinningState(self, action: SKAction.playerWin())
        ])
        
        self.addComponent(AnimationStateMachineComponent(stateMachine: animationStateMachine))
        
        let node = SKSpriteNode(imageNamed: "playerRun1")
        node.size = CGSize(width: 128, height: 128)
        node.position = position
        node.zPosition = 10
        self.addComponent(GKSKNodeComponent(node: node))
        
        let size: CGSize = .init(width: node.size.width / 2, height: node.size.height - 4)
        let physicsComp = PhysicsComponent.capsule(size: size, cornerRadius: 10)
        physicsComp.body.allowsRotation = false
        physicsComp.body.restitution = 0.0
        physicsComp.body.categoryBitMask = .player
        physicsComp.body.friction = 0
        physicsComp.body.contactTestBitMask = .contactWithAllCategories()
        physicsComp.body.collisionBitMask = .contactWithAllCategories(less: [.enemy, .item, .bullet, .trap])
        
        self.addComponent(physicsComp)
        
        self.addComponent(MovementComponent(velocityX: 100 * 4, direction: .right, entityType: .gravityAffected))
        self.addComponent(JumpComponent(forceY: 310, forceX: 250))
        self.addComponent(WallSlideComponent())
        
        self.addComponent(DeathComponent())
        self.addComponent(DestructableComponent())
        self.addComponent(TorchComponent())
        
        self.addComponent(WinComponent())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
