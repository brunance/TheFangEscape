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
    
    weak var deathComp: DeathComponent?
    
    //Time to die after the light runs out
    private var timeToDeath: TimeInterval = 5
    
    //Timer for the light to run out
    private var timeElapsed: TimeInterval = 0
    private var duration: TimeInterval = 5
    
    private var timeLeft: TimeInterval = -1
    
    private var eyesCreated = 0
    private var eyesCreationTimer: Timer?
    
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
        deathComp = entity?.component(ofType: DeathComponent.self)
        
        let lightComp = LightComponent(color: .init(red: 1, green: 0.5, blue: 0, alpha: 1))
        entity?.addComponent(lightComp)
        self.lightComp = lightComp
        
        lightComp.lightNode.falloff = 1
        lightComp.lightNode.zPosition = 2
        lightComp.lightNode.categoryBitMask = LightMask.torch
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func update(deltaTime seconds: TimeInterval) {
        
        timeElapsed += seconds
        
        if timeElapsed < duration {
            decay()
        } else if let deathComp = deathComp, !deathComp.deathHasStarted {
            timeToDeath -= seconds
            timeLeft += seconds
            
            if eyesCreationTimer == nil && eyesCreated < 5 {
                startEyesCreationTimer()
            }
            
            if timeToDeath <= 0 {
                deathComp.startDeath(by: .trap)
            }
        }
    }
    
    private func decay() {
        let progress = CGFloat(timeElapsed / duration) * speedFactor
        intensity = 1 - (1 * progress)
    }
    
    public func restore() {
        timeElapsed = 0
        intensity = 1
        
        removeVampireEyes()
    }
    
    public func accelerateProgress() {
        speedFactor = 1.5
    }
    
    public func normalizeProgress() {
        speedFactor = 1
    }
    
    private func startEyesCreationTimer() {
        let interval = 1.0
        
        eyesCreationTimer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(spawnEyes), userInfo: nil, repeats: true)
    }
    
    @objc private func spawnEyes() {
        guard let scene = self.node?.scene as? GameScene,
        let node = entity?.component(ofType: GKSKNodeComponent.self)?.node else { return }
        
        let vampireEye = SKSpriteNode(imageNamed: "vampireEyes")
        
        vampireEye.size = CGSize(width: 90, height: 22.5)
        vampireEye.zPosition = 10
        vampireEye.position = node.position
        vampireEye.alpha = 0
        
        let light = SKLightNode()
        light.lightColor = .red
        light.falloff = 5
        vampireEye.addChild(light)
        
        scene.addChild(vampireEye)
        
        let fadeInAction = SKAction.fadeIn(withDuration: 0.5)
        vampireEye.run(fadeInAction)
        
        eyesCreated += 1
        
        if eyesCreated >= 4 {
            eyesCreationTimer?.invalidate()
            eyesCreationTimer = nil
        }
    }
    
    public func removeVampireEyes() {
        guard let scene = self.node?.scene as? GameScene else { return }

        scene.enumerateChildNodes(withName: "vampireEye") { node, _ in
            node.removeFromParent()
        }

        timeToDeath = 5
        timeLeft = -1
        eyesCreated = 0
        eyesCreationTimer?.invalidate()
        eyesCreationTimer = nil
    }
}
