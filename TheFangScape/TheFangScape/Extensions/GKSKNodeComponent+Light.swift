//
//  GKSKNodeComponent+Light.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 18/11/23.
//

import Foundation
import GameplayKit
import SpriteKit

extension GKSKNodeComponent {
    
    public func defaultLight() {
        if let sprite = node as? SKSpriteNode {
            sprite.lightingBitMask = LightMask.contactWithAllCategories()
        }
    }
    
    open override func didAddToEntity() {
        super.didAddToEntity()
        self.defaultLight()
    }
    
}
