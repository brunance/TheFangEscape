//
//  RotatingComponent.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 29/11/23.
//

import Foundation
import GameplayKit

class RotatingComponent: GKComponent {
    
    weak var node: SKNode?
    var rotatingSpeed: CGFloat
    
    public init(rotatingSpeed: CGFloat) {
        self.rotatingSpeed = rotatingSpeed
        super.init()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
        node = entity?.component(ofType: GKSKNodeComponent.self)?.node
        
        rotate()
    }
    
    private func rotate() {
        node?.run(.repeatForever(SKAction.rotate(byAngle: rotatingSpeed, duration: 1.0)))
    }
    
    
}
