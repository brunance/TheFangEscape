//
//  SpikeEntity.swift
//  TheFangScape
//
//  Created by Joao Lucas Camilo on 24/11/23.
//


import Foundation
import GameplayKit
import SpriteKit

public class SpikeEntity: GKEntity {
    
    public init(position:CGPoint = .zero) {
        super.init()
        
        let node = SKSpriteNode(color: .red, size: .init(width: 20, height: 20))
        node.position = position
        self.addComponent(GKSKNodeComponent(node: node))
        
        let physicsComp = PhysicsComponent.rectangleBody(ofSize: node.size)
        physicsComp.body.affectedByGravity = false
        physicsComp.body.isDynamic = false
        physicsComp.body.categoryBitMask = .item
        physicsComp.body.contactTestBitMask = .contactWithAllCategories(less:[.enemy,.ground,.trap,.bullet,.ice,.wall,.endPoint] )
        self.addComponent(physicsComp)
        
        
        self.addComponent(isSpikeComponent())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
