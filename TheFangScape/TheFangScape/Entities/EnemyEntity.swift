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
        let node = SKSpriteNode(texture: nodeTexture, size: CGSize(width: 100, height: 100))
        node.position = position
        self.addComponent(GKSKNodeComponent(node: node))
        
        let physicsComp = PhysicsComponent.rectangleBody(ofSize: .init(width: 48, height: 48))
        physicsComp.body.categoryBitMask = .enemy
        physicsComp.body.contactTestBitMask = .player
        physicsComp.body.affectedByGravity = false
        
        let animationStateMachine : GKStateMachine = .init(states: [
            RunningState(self, action: SKAction.enemyRun())
        ])
        
        animationStateMachine.enter(RunningState.self)
        self.addComponent(AnimationStateMachineComponent(stateMachine: animationStateMachine))
        
        self.addComponent(physicsComp)
        
        self.addComponent(MovementComponent(velocityX: 100 * 4, direction: .right, entityType: .nonGravityAffected))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
