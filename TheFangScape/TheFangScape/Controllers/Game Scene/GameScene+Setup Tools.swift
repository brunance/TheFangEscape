//
//  GameScene+Navigation.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 30/11/23.
//

import Foundation
import SpriteKit
import GameplayKit

extension GameScene :SKPhysicsContactDelegate {
    
    //MARK: Scene control functions
    internal func startUpScene(withName levelName: String) {
        entityManager = SKEntityManager(scene: self)
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -10.0)
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
    
    internal func restartLevel() {
        startEndLevelAnimation {
            self.entityManager?.removeAll()
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
    
    //MARK: Contact check functions
    public func didBegin(_ contact: SKPhysicsContact) {
        
        guard let entityA = contact.bodyA.node?.entity,
              let entityB = contact.bodyB.node?.entity else { return }
        
        checkForContactPlayerAndItemBegin(entityA: entityA, entityB: entityB)
        checkForContactPlayerAndItemBegin(entityA: entityB, entityB: entityA)
        
        checkForContactPlayerAndIceBegin(entityA: entityB, entityB: entityA)
        checkForContactPlayerAndIceBegin(entityA: entityA, entityB: entityB)
        
        checkForContactPlayerAndTrapBegin(entityA: entityA, entityB: entityB)
        checkForContactPlayerAndTrapBegin(entityA: entityB, entityB: entityA)
        
        checkForContactPlayerAndSpikeBegin(entityA: entityA, entityB: entityB)
        checkForContactPlayerAndSpikeBegin(entityA: entityB, entityB: entityA)
        
        checkForContactPlayerAndDoor(entityA: entityA, entityB: entityB)
        checkForContactPlayerAndDoor(entityA: entityB, entityB: entityA)
        
        checkForContactPlayerAndEnemy(entityA: entityA, entityB: entityB)
        checkForContactPlayerAndEnemy(entityA: entityB, entityB: entityA)
    }
    
    public func didEnd(_ contact: SKPhysicsContact) {
        guard let entityA = contact.bodyA.node?.entity,
              let entityB = contact.bodyB.node?.entity else { return }
        
        checkForContactPlayerAndIceEndend(entityA: entityB, entityB: entityA)
        checkForContactPlayerAndIceEndend(entityA: entityA, entityB: entityB)
    }
    
    
    public func checkForContactPlayerAndItemBegin(entityA: GKEntity, entityB: GKEntity) {
        if (entityA.component(ofType: IsPlayerComponent.self) != nil &&
            entityB.component(ofType: IsItemComponent.self) != nil) {
            entityA.component(ofType: TorchComponent.self)?.restore()
            entityManager?.remove(entity: entityB)
        }
    }
    
    public func checkForContactPlayerAndIceBegin(entityA: GKEntity, entityB: GKEntity) {
        if (entityA.component(ofType: IsPlayerComponent.self) != nil &&
            entityB.component(ofType: IsIceComponent.self) != nil) {
            playerEntity?.torchComponent?.accelerateProgress()
        }
    }
    
    public func checkForContactPlayerAndDoor(entityA: GKEntity, entityB: GKEntity) {
        if (entityA.component(ofType: IsPlayerComponent.self) != nil &&
            entityB.component(ofType: IsDoorComponent.self) != nil) {
            playerEntity?.winComponent?.startWin()
            playerEntity?.torchComponent?.restore()
        }
    }
    
    public func checkForContactPlayerAndIceEndend(entityA: GKEntity, entityB: GKEntity)  {
        if (entityA.component(ofType: IsPlayerComponent.self) != nil &&
            entityB.component(ofType: IsIceComponent.self) != nil) {
            playerEntity?.torchComponent?.normalizeProgress()
        }
    }
    
    public func checkForContactPlayerAndTrapBegin(entityA: GKEntity, entityB: GKEntity) {
        let isPlayerAndTrapContact = (entityA.component(ofType: IsPlayerComponent.self) != nil &&
                                      entityB.component(ofType: IsTrapComponent.self) != nil)
        
        let isPlayerAndBulletContact = (entityA.component(ofType: IsPlayerComponent.self) != nil &&
                                        entityB.component(ofType: IsBulletComponent.self) != nil)

        if isPlayerAndTrapContact || isPlayerAndBulletContact {
            playerEntity?.deathComponent?.startDeath(by: .trap)
        }
    }
    
    public func checkForContactPlayerAndSpikeBegin(entityA: GKEntity, entityB: GKEntity) {
        let isPlayerAndSpikeContact = (entityA.component(ofType: IsPlayerComponent.self) != nil &&
                                      entityB.component(ofType: IsSpikeComponent.self) != nil)

        if isPlayerAndSpikeContact {
            playerEntity?.deathComponent?.startDeath(by: .trap)
        }
    }
    
    public func checkForContactPlayerAndEnemy(entityA: GKEntity, entityB: GKEntity) {
        let isPlayerAndEnemyContact = (entityA.component(ofType: IsPlayerComponent.self) != nil &&
                                      entityB.component(ofType: IsEnemyComponent.self) != nil)

        if isPlayerAndEnemyContact {
            playerEntity?.deathComponent?.startDeath(by: .trap)
        }
    }
}
