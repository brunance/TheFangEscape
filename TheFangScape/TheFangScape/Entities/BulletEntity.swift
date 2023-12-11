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
    
    var bulletDirection: Direction
    
    public init(position: CGPoint = .zero, bulletDirection: Direction) {
        self.bulletDirection = bulletDirection
        super.init()
        
        let nodeTexture = SKTexture(imageNamed: "bullet")
        let node = SKSpriteNode(texture: nodeTexture, size: .init(width: 50, height: 50))
        node.position = position
        node.xScale = bulletDirection == .right ? 1 : -1
        self.addComponent(GKSKNodeComponent(node: node))
        
        let physicsComp = PhysicsComponent.rectangleBody(ofSize: .init(width: 50, height: 50))
        physicsComp.body.allowsRotation = false
        physicsComp.body.affectedByGravity = false
        physicsComp.body.mass = 100
        physicsComp.body.categoryBitMask = .bullet
        physicsComp.body.contactTestBitMask = .player
        
        self.addComponent(physicsComp)
        
        self.addComponent(MovementComponent(velocityX: 320, direction: bulletDirection, entityType: .nonGravityAffected))
        
        let lightComp = LightComponent(color: .white)
        lightComp.setIntensity(1)
        lightComp.lightNode.falloff = 2
        self.addComponent(lightComp)
        
        self.addComponent(RemoveWhenTouchWall())
        self.addComponent(DestructableComponent())
        self.addComponent(IsBulletComponent())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
