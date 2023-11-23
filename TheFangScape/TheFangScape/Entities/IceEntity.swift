//
//  IceEntity.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 22/11/23.
//

import Foundation
import GameplayKit
import SpriteKit

public class IceEntity: GKEntity {
    
    public init(position: CGPoint, size: CGSize) {
        super.init()
        
        let nodeColor = UIColor(red: 173/255.0, green: 216/255.0, blue: 230/255.0, alpha: 1.0)
        let node = SKSpriteNode(color: nodeColor, size: size)
        node.position = position
        self.addComponent(GKSKNodeComponent(node: node))
        
        let physicsComp = PhysicsComponent.rectangleBody(ofSize: node.calculateAccumulatedFrame().size)
        physicsComp.body.affectedByGravity = false
        physicsComp.body.isDynamic = false

        physicsComp.body.categoryBitMask = .ice
        physicsComp.body.contactTestBitMask = .player
        self.addComponent(physicsComp)    
        self.addComponent(IsGroundComponent())
        self.addComponent(IsWallComponent())
        self.addComponent(IsIceComponent())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
