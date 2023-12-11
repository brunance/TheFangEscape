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

    public init(position: CGPoint = .zero, entityManager : SKEntityManager, shootDirection: Direction, size: CGSize) {
        super.init()
        
        let nodeTexture = SKTexture(imageNamed: "shootTrap")
        let node = SKSpriteNode(texture: nodeTexture, size: size)
        node.position = position
        node.xScale = shootDirection == .right ? 1 : -1
        self.addComponent(GKSKNodeComponent(node: node))
        
        let physicsComp = PhysicsComponent.capsule(size: node.size, cornerRadius: 2)
        physicsComp.body.allowsRotation = false
        physicsComp.body.affectedByGravity = false
        physicsComp.body.isDynamic = false
        physicsComp.body.categoryBitMask = .trap
        
        self.addComponent(physicsComp)
        
        self.addComponent(ShootComponent(entityManager: entityManager, bulletDirection: shootDirection))
        self.addComponent(IsTrapComponent())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
