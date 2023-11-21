//
//  TrapEntity.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 21/11/23.
//

import Foundation
import GameplayKit
import SpriteKit

public class TrapEntity: GKEntity {
    
    weak var entityManager: SKEntityManager?
    var shootDirection: PlayerDirection
    
    public init(position: CGPoint = .zero, entityManager : SKEntityManager, shootDirection: PlayerDirection) {
        self.shootDirection = shootDirection
        self.entityManager = entityManager
        super.init()
        
        let node = SKSpriteNode(color: .blue, size: .init(width: 48, height: 48))
        node.position = position
        self.addComponent(GKSKNodeComponent(node: node))
        
        let physicsComp = PhysicsComponent.rectangleBody(ofSize: .init(width: 48, height: 48))
        physicsComp.body.allowsRotation = false
        physicsComp.body.categoryBitMask = .trap
        physicsComp.body.collisionBitMask = .contactWithAllCategories(less: [.bullet])
        
        self.addComponent(physicsComp)
        
        self.addComponent(ShootComponent(bulletVelocity: 500.0, entityManager: entityManager, bulletDirection: shootDirection))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
