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

    public init(position: CGPoint = .zero, entityManager : SKEntityManager, shootDirection: Direction) {
        super.init()
        
        let node = SKSpriteNode(color: .blue, size: .init(width: 48, height: 48))
        node.position = position
        self.addComponent(GKSKNodeComponent(node: node))
        
        let physicsComp = PhysicsComponent.capsule(size: node.size, cornerRadius: 2)
        physicsComp.body.allowsRotation = false
        physicsComp.body.affectedByGravity = false
        physicsComp.body.categoryBitMask = .trap
        physicsComp.body.contactTestBitMask = .player
        physicsComp.body.collisionBitMask = .contactWithAllCategories(less: [.bullet])
        
        self.addComponent(physicsComp)
        
        self.addComponent(ShootComponent(entityManager: entityManager, bulletDirection: shootDirection))
        self.addComponent(IsTrapComponent())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
