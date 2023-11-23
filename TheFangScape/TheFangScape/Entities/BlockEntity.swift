//
//  BlockEntity.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 17/11/23.
//

import Foundation
import GameplayKit
import SpriteKit

public class BlockEntity: GKEntity {
    
    public init(position: CGPoint = .zero) {
        super.init()
        
        let node = SKSpriteNode(color: .brown, size: .init(width: 45, height: 45))
        node.position = position
        self.addComponent(GKSKNodeComponent(node: node))
        
        let physicsComp = PhysicsComponent.capsule(size: node.size, cornerRadius: 1)
        physicsComp.body.affectedByGravity = false
        physicsComp.body.isDynamic = false
        self.addComponent(physicsComp)
        
        self.addComponent(IsGroundComponent())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
