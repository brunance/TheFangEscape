//
//  LightComponent.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 18/11/23.
//

import Foundation
import GameplayKit
import SpriteKit

public class LightComponent: GKComponent {
    
    public var lightNode: SKLightNode
    
    public init(color: SKColor) {
        self.lightNode = SKLightNode()
        super.init()
        
        lightNode.lightColor = color
    }
    
    public override func didAddToEntity() {
        guard let node = entity?.component(ofType: GKSKNodeComponent.self)?.node else { return }
        node.addChild(lightNode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setIntensity(_ amount: CGFloat) {
        let correctAmount = min(1, max(0, amount))
        let color = lightNode.lightColor
        lightNode.lightColor = color.withAlphaComponent(correctAmount)
    }
}
