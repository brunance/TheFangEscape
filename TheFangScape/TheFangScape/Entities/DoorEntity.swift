//
//  DoorEntity.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 24/11/23.
//

import Foundation
import GameplayKit

class DoorEntity: GKEntity {
    
    public init(position: CGPoint, size: CGSize) {
        super.init()
        
        let nodeColor = UIColor(red: 173/255.0, green: 216/255.0, blue: 230/255.0, alpha: 1.0)
        let node = SKSpriteNode(color: nodeColor, size: size)
        node.position = position
        self.addComponent(GKSKNodeComponent(node: node))
        
        let physicsComp = PhysicsComponent.rectangleBody(ofSize: node.calculateAccumulatedFrame().size)
        physicsComp.body.affectedByGravity = false
        physicsComp.body.isDynamic = false

        physicsComp.body.categoryBitMask = 0
        physicsComp.body.contactTestBitMask = .player
        self.addComponent(physicsComp)

        self.addComponent(IsDoorComponent())
        
        let lightComp = LightComponent(color: .init(
            red: 0.3, green: 0.3, blue: 0.4, alpha: 0.2))
        self.addComponent(lightComp)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
