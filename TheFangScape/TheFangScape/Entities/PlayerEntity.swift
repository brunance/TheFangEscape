//
//  PlayerEntity.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 13/11/23.
//

import Foundation
import GameplayKit
import SpriteKit

public class PlayerEntity: GKEntity {
    
    public var jumpComponent: JumpComponent? {
        return self.component(ofType: JumpComponent.self)
    }
    
    public init(position: CGPoint = .zero) {
        super.init()
        
        let node = SKSpriteNode(color: .blue, size: .init(width: 32, height: 32))
        node.position = position
        self.addComponent(GKSKNodeComponent(node: node))
        
        let physicsComp = PhysicsComponent.rectangleBody(ofSize: node.size)
        self.addComponent(physicsComp)
        
        self.addComponent(MovementComponent(velocityX: 100))
        self.addComponent(JumpComponent(forceY: 32, forceX: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
