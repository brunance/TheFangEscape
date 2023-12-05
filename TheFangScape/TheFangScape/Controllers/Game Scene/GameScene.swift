//
//  GameScene.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 13/11/23.
//

import Foundation
import SpriteKit
import GameplayKit

public class GameScene: SKScene {
    
    public var entityManager: SKEntityManager?
    
    private var lastUpdatedTime: TimeInterval = 0
    
    internal weak var playerEntity: PlayerEntity?
    
    internal var mask = SKCropNode()
    
    public override init(size: CGSize) {
        super.init(size: size)
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFill
        self.mask.maskNode = SKSpriteNode(imageNamed: "mask")
        self.mask.maskNode?.setScale(5)
        self.addChild(mask)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func sceneDidLoad() {
        startUpScene(withName: LevelManager.shared.currentLevelName)
    }

    public override func update(_ currentTime: TimeInterval) {
        if (lastUpdatedTime == 0) {
            lastUpdatedTime = currentTime
        }
        
        let deltaTime = currentTime - lastUpdatedTime
        
        entityManager?.update(atTime: deltaTime)
        
        lastUpdatedTime = currentTime
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        playerEntity?.jumpComponent?.tryJump()
    }
}

extension GameScene: SKPhysicsContactDelegate {
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
            playerEntity?.deathComponent?.startDeath(by: isPlayerAndTrapContact ? .trap : .dark)
        }
    }
    
    public func checkForContactPlayerAndSpikeBegin(entityA: GKEntity, entityB: GKEntity) {
        let isPlayerAndSpikeContact = (entityA.component(ofType: IsPlayerComponent.self) != nil &&
                                      entityB.component(ofType: IsSpikeComponent.self) != nil)

        if isPlayerAndSpikeContact {
            playerEntity?.deathComponent?.startDeath(by: isPlayerAndSpikeContact ? .trap : .dark)
        }
    }
}
