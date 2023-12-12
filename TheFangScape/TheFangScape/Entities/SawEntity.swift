//
//  SawEntity.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 29/11/23.
//

import Foundation
import GameplayKit

class SawEntity: GKEntity {
    
    public init(position: CGPoint = .zero, size: CGSize) {
        super.init()
        
        let node = SKSpriteNode(color: .gray, size: size)
        node.position = position
        self.addComponent(GKSKNodeComponent(node: node))
        
        let physicsComp = PhysicsComponent.rectangleBody(ofSize: node.size)
        physicsComp.body.affectedByGravity = false
        physicsComp.body.isDynamic = false
        physicsComp.body.categoryBitMask = .trap
        physicsComp.body.contactTestBitMask = .player
        
        self.addComponent(physicsComp)
        self.addComponent(MovementComponent(velocityX: 32, direction: .right, entityType: .nonGravityAffected))
        self.addComponent(RotatingComponent(rotatingSpeed: 10.0))
        self.addComponent(IsSawComponent())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
