//
//  ScenarioEntity.swift
//  Chiko Liru
//
//  Created by Victor Vasconcelos on 18/10/23.
//

import Foundation
import GameplayKit
import SpriteKit

public class ScenarioEntity: GKEntity {
    
    public init(levelData: LevelData, entityManager: SKEntityManager) {
        super.init()
               
        if let node = SKTileMapNode.createTileMapNode(fromLevelData: levelData, entityManager: entityManager) {
            self.addComponent(GKSKNodeComponent(node: node))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
