//
//  GameScene.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 13/11/23.
//

import Foundation
import SpriteKit

public class GameScene: SKScene {
    
    public var entityManager: SKEntityManager?
    
    private var lastUpdatedTime: TimeInterval = 0
    
    private weak var playerEntity: PlayerEntity?
    
    public override init(size: CGSize) {
        super.init(size: size)
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func sceneDidLoad() {
        entityManager = SKEntityManager(scene: self)
        
        setupScene()
        
        do {
            let enemy = TrapEntity(position: .init(x: -90, y: 0), entityManager: entityManager!, shootDirection: .right)
            entityManager?.add(entity: enemy)
        }
    }

    private func setupScene() {
        self.backgroundColor = .black
        
        guard let entityManager,
        let levelData = TileSetManager.shared.loadScenarioData(named: "level1") else { return }
        
        let scenario = ScenarioEntity(levelData: levelData, entityManager: entityManager)
        entityManager.add(entity: scenario)

        playerEntity = entityManager.first(withComponent: IsPlayerComponent.self) as? PlayerEntity
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
