//
//  BulletEntity.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 21/11/23.
//

import Foundation
import GameplayKit
import SpriteKit

public class BulletEntity: GKEntity {
    
    public init(position: CGPoint = .zero) {
        super.init()
        
        let node = SKSpriteNode(color: .yellow, size: .init(width: 10, height: 10))
        node.position = position
        self.addComponent(GKSKNodeComponent(node: node))
        
        let physicsComp = PhysicsComponent.rectangleBody(ofSize: .init(width: 10, height: 10))
        physicsComp.body.allowsRotation = false
        physicsComp.body.affectedByGravity = false
        physicsComp.body.categoryBitMask = .bullet
        physicsComp.body.collisionBitMask = .contactWithAllCategories(less: [.trap, .bullet])
        
        self.addComponent(physicsComp)
        
        self.addComponent(MovementComponent(velocityX: 320, direction: .right))
        self.addComponent(LightComponent(color: .white))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
