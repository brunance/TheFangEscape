//
//  PlatformEntity.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 17/11/23.
//

import Foundation
import GameplayKit

public class PlatformEntity: GKEntity {
    
    public init(position: CGPoint = .zero, size: CGSize) {
        super.init()
        
        let node = SKSpriteNode(color: .blue, size: size)
        node.position = position
        self.addComponent(GKSKNodeComponent(node: node))
        
        let physicsComp = PhysicsComponent.rectangleBody(ofSize: node.size)
        physicsComp.body.mass = 9999
        physicsComp.body.affectedByGravity = false
        physicsComp.body.allowsRotation = false
        
        self.addComponent(physicsComp)
        self.addComponent(MovementComponent(velocityX: 12 * 8, direction: .left, entityType: .nonGravityAffected))
        self.addComponent(IsGroundComponent())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
