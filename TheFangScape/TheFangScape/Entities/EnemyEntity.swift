//
//  EnemyEntity.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 19/11/23.
//

import Foundation
import GameplayKit
import SpriteKit

public class EnemyEntity: GKEntity {
    
    public init(position: CGPoint = .zero, size: CGSize) {
        super.init()
        
        let nodeTexture = SKTexture(imageNamed: "enemyBat0")
        let node = SKSpriteNode(texture: nodeTexture, size: size)
        node.position = position
        self.addComponent(GKSKNodeComponent(node: node))
        
        let physicsComp = PhysicsComponent.circle(ofRadius: .init(size.width / 2))
        physicsComp.body.categoryBitMask = .enemy
        physicsComp.body.contactTestBitMask = .player
        physicsComp.body.affectedByGravity = false
        physicsComp.body.collisionBitMask = .contactWithAllCategories(less: [.player, .item, .bullet, .trap])
        
        let animationStateMachine : GKStateMachine = .init(states: [
            RunningState(self, action: SKAction.enemyRun())
        ])
        
        animationStateMachine.enter(RunningState.self)
        self.addComponent(AnimationStateMachineComponent(stateMachine: animationStateMachine))
        
        self.addComponent(physicsComp)
        
        self.addComponent(MovementComponent(velocityX: 100 * 4, direction: .right, entityType: .nonGravityAffected))
        self.addComponent(IsEnemyComponent())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
