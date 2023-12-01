//
//  GameScene+Navigation.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 30/11/23.
//

import Foundation
import SpriteKit
import GameplayKit

extension GameScene {
    
    internal func startUpScene(withName levelName: String) {
        entityManager = SKEntityManager(scene: self)
        physicsWorld.contactDelegate = self
        setupScene(levelNamed: levelName)
    }
    
    internal func setupScene(levelNamed: String) {
        self.mask.maskNode?.setScale(5)
        self.backgroundColor = .black

        guard let entityManager,
        let levelData = TileSetManager.shared.loadScenarioData(named: levelNamed) else { return }
        
        let scenario = ScenarioEntity(levelData: levelData, entityManager: entityManager)
        entityManager.add(entity: scenario)

        self.playerEntity = entityManager.first(withComponent: IsPlayerComponent.self) as? PlayerEntity

        setupCamera()
    }
    
    private func setupCamera() {
        let camera = SKCameraNode()
        self.addChild(camera)
        self.camera = camera
        self.camera?.setScale(1.2)
    }
    
    internal func finishLevel() {
        startEndLevelAnimation {
            self.entityManager?.removeAll()
            LevelManager.shared.nextLevel()
            self.startUpScene(withName: LevelManager.shared.currentLevelName)
        }
    }
    
    private func startEndLevelAnimation(completion: @escaping ()->Void) {
        mask.maskNode?.position = playerEntity?.node?.position ?? .zero
        mask.maskNode?.run(.sequence([
            .scale(to: 0, duration: 0.8),
            .run {
                completion()
            }
        ]))
    }
    
    public func present(levelNamed: String) {
        startUpScene(withName: levelNamed)
    }
    
}
