//
//  ItemEntity.swift
//  TheFangScape
//
//  Created by Gabriel Dias Goncalves on 21/11/23.
//

import Foundation
import GameplayKit
import SpriteKit

public class ItemEntity : GKEntity {
    
    public init(position:CGPoint = .zero) {
        super.init()
        
        let node = SKSpriteNode(color: .yellow, size: .init(width: 20, height: 20))
        node.position = position
        self.addComponent(GKSKNodeComponent(node: node))
        
        let physicsComp = PhysicsComponent.rectangleBody(ofSize: node.size)
        physicsComp.body.affectedByGravity = false
        physicsComp.body.isDynamic = false
        physicsComp.body.categoryBitMask = .item
        physicsComp.body.contactTestBitMask = .contactWithAllCategories(less:[.enemy,.ground,.trap,.bullet,.ice,.wall,.endPoint] )
        self.addComponent(physicsComp)
       
        let lightComp = LightComponent(color: .init(red: 1, green: 1, blue: 1, alpha: 1))
        lightComp.setIntensity(0.3)
        self.addComponent(lightComp)
        self.addComponent(DestructableComponent())
        self.addComponent(IsItemComponent())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
