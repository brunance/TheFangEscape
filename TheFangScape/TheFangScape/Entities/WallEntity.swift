//
//  WallEntity.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 14/11/23.
//

import Foundation
import GameplayKit
import SpriteKit

public class WallEntity: GKEntity {
    
    public init(position: CGPoint = .zero) {
        super.init()
        
        let node = SKSpriteNode(color: .yellow, size: .init(width: 50, height: 50))
        node.position = position
        self.addComponent(GKSKNodeComponent(node: node))
        
        let physicsComp = PhysicsComponent.rectangleBody(ofSize: node.size)
        physicsComp.body.affectedByGravity = false
        physicsComp.body.isDynamic = false
        self.addComponent(physicsComp)
        
        self.addComponent(IsWallComponent())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
