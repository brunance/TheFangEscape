//
//  TorchComponent.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 18/11/23.
//

import Foundation
import GameplayKit

public class TorchComponent: GKComponent {
    
    weak var node: SKNode?

    private var timeElapsed: TimeInterval = 0
    private var duration: TimeInterval = 15
    
    var speedFactor: CGFloat = 1
    
    private var intensity: CGFloat {
        didSet {
            lightComp?.setIntensity(intensity)
        }
    }
    
    private weak var lightComp: LightComponent?
    
    public override init() {
        self.intensity = 1
        super.init()
    }
    
    public override func didAddToEntity() {
        node = entity?.component(ofType: GKSKNodeComponent.self)?.node
        
        let lightComp = LightComponent(color: .init(red: 1, green: 0.8, blue: 0.7, alpha: 1))
        entity?.addComponent(lightComp)
        self.lightComp = lightComp
        
        lightComp.lightNode.falloff = 2
        lightComp.lightNode.categoryBitMask = LightMask.torch
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func update(deltaTime seconds: TimeInterval) {
        
        timeElapsed += seconds
        
        if timeElapsed < duration {
            decay()
        }
    }
    
    private func decay() {
        let progress = CGFloat(timeElapsed / duration) * speedFactor
        intensity = 1 - (1 * progress)
    }
    
    public func restore() {
        timeElapsed = 0
        intensity = 1
    }
    
    public func accelerateProgress() {
        speedFactor = 1.5
    }
    
    public func normalizeProgress() {
        speedFactor = 1
    }
}
