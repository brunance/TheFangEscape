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
    
    public init(position:CGPoint = .zero, size: CGSize, xValue: CGFloat, yValue: CGFloat, zRotation: CGFloat) {
        super.init()
        
        let nodeTexture = SKTexture(imageNamed: "spike")
        let node = SKSpriteNode(texture: nodeTexture, size: size)
        node.position = position
        node.xScale = xValue
        node.yScale = yValue
        node.zRotation = zRotation
        self.addComponent(GKSKNodeComponent(node: node))
        
        let physicsComp = PhysicsComponent.rectangleBody(ofSize: node.size)
        physicsComp.body.affectedByGravity = false
        physicsComp.body.isDynamic = false
        physicsComp.body.categoryBitMask = .trap
        physicsComp.body.contactTestBitMask = .player
        self.addComponent(physicsComp)
        
        
        self.addComponent(IsSpikeComponent())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
