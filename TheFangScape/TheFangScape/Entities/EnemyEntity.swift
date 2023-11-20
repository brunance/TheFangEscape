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
    
    public init(position: CGPoint = .zero) {
        super.init()
        
        
        let node = SKSpriteNode(color: .red, size: .init(width: 48, height: 48))
        node.position = position
        self.addComponent(GKSKNodeComponent(node: node))
        
        let physicsComp = PhysicsComponent.rectangleBody(ofSize: .init(width: 48, height: 48))
        physicsComp.body.allowsRotation = false
        physicsComp.body.linearDamping = 0.5
        physicsComp.body.restitution = 0.0
        physicsComp.body.categoryBitMask = .enemy
        physicsComp.body.collisionBitMask = .contactWithAllCategories(less: [.player])
        
        self.addComponent(physicsComp)
        
        self.addComponent(MovementComponent(velocityX: 32 * 8, direction: .left))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
