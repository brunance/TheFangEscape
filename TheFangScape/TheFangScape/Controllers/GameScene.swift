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

        // JUST FOR TEST GROUND CHECK
        let groundEntity = GroundEntity(position: .init(x: 0, y: -400))
        entityManager?.add(entity: groundEntity)
        
        // JUST FOR TEST WALL CHECK
        do {
            let wall = WallEntity(position: .init(x: 225, y: -350))
            entityManager?.add(entity: wall)
        }
        
        do {
            let wall = WallEntity(position: .init(x: -225, y: -350))
            entityManager?.add(entity: wall)
        }
        
        for i in 1...4 {
            let block = ChangeStateBlockEntity(position: .init(x: 45 * i , y: -300))
            entityManager?.add(entity: block)
        }
    }
    
    private func setupScene() {
        self.backgroundColor = .black
        
        let playerEntity = PlayerEntity()
        entityManager?.add(entity: playerEntity)
        self.playerEntity = playerEntity
        
        let itemEntity = ItemEntity(position: .init(x: -150, y: -250))
        entityManager?.add(entity: itemEntity)
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
