//
//  AddPhysicsToTileMap.swift
//  SpriteChicken
//
//  Created by Victor Vasconcelos on 02/02/23.
//

import Foundation
import SpriteKit

enum TileType: String {
    case ground = "ground"
    case player = "player"
    case wall = "wall"
    case trapShoot = "trapShoot"
    case trapSpike = "trapSpike"
    case trapSaw = "trapSaw"
    case light = "item"
    case door = "door"
    case changeBlock = "changeBlock"
    case platform = "platform"
    case enemy = "enemy"
}

extension SKTileMapNode {
    
    static func createTileMapNode(fromJSON named: String, entityManager: SKEntityManager) -> SKNode? {
        
        guard let levelData = TileSetManager.shared.loadScenarioData(named: named) else { return nil }
        
        return createTileMapNode(fromLevelData: levelData, entityManager: entityManager)
    }
    
    static func createTileMapNode(fromLevelData levelData: LevelData, entityManager: SKEntityManager) -> SKNode? {
        let node = SKNode()
                
        for layer in levelData.layers {
            
            guard !layer.name.contains("prototype") else { continue }
            
            let mapNode = SKTileMapNode(tileSet: .init(), columns: layer.width, rows: layer.height, tileSize: levelData.tileSize)
            mapNode.enableAutomapping = false
            
            var col = 0
            var row = 0
            
            for (i, tileId) in layer.data.enumerated() {
                let mappedId = tileId - 1
                guard mappedId >= 0 else { continue }
                
                guard let tileDef = TileSetManager.shared.groundSetData?.getTileDefinition(at: mappedId) else { continue }
                
                col = i % layer.width
                row = layer.height - (i / layer.width)
                
                if !layer.isNotRendered {
                    let group = SKTileGroup(tileDefinition: tileDef)
                    mapNode.tileSet.tileGroups.append(group)
                    mapNode.setTileGroup(group, forColumn: col, row: row)
                    mapNode.lightingBitMask = LightMask.contactWithAllCategories()
                }
                
                // Factory Entities
                let tilePosition = mapNode.centerOfTile(atColumn: col, row: row)
                factoryTiles(entityManager: entityManager,
                             tileDefinition: tileDef,
                             tilePosition: tilePosition,
                             tileSize: levelData.tileSize)
            }
            node.addChild(mapNode)
        }
        
        return node
    }
    
    static func factoryTiles(entityManager: SKEntityManager, 
                             tileDefinition: SKTileDefinition,
                             tilePosition: CGPoint,
                             tileSize: CGSize) {
        guard let tileData = tileDefinition.userData?.value(forKey: "type") as? String else {
            return
        }

        switch tileData {
        case TileType.ground.rawValue:
            let groundEntity = GroundEntity(position: tilePosition, size: tileSize)
            entityManager.add(entity: groundEntity)
        case TileType.player.rawValue:
            let player = PlayerEntity(position: tilePosition)
            entityManager.add(entity: player)
        case TileType.trapShoot.rawValue:
            let data = (tileDefinition.userData?.value(forKey: "direction") as? String)
            let direction: Direction = data == "1" ? .right : .left
            let trap = TrapEntity(position: tilePosition, entityManager: entityManager, shootDirection: direction, size: tileSize)
            entityManager.add(entity: trap)
        case TileType.light.rawValue:
            let light = ItemEntity(position: tilePosition, size: tileSize)
            entityManager.add(entity: light)
        case TileType.door.rawValue:
            let door = DoorEntity(position: tilePosition, size: tileSize)
            entityManager.add(entity: door)
        case TileType.changeBlock.rawValue:
            let data = (tileDefinition.userData?.value(forKey: "status") as? String)
            let status: Status = data == "active" ? .active : .desactive
            let block = ChangeStateBlockEntity(position: tilePosition, size: tileSize, status: status)
            entityManager.add(entity: block)
        case TileType.trapSpike.rawValue:
            let data = (tileDefinition.userData?.value(forKey: "location") as? String)
            
            switch data {
            case "ground":
                let spike = SpikeEntity(position: tilePosition, size: tileSize, xValue: 1, yValue: 1, zRotation: 0)
                entityManager.add(entity: spike)
            case "roof":
                let spike = SpikeEntity(position: tilePosition, size: tileSize, xValue: 1, yValue: -1, zRotation: 0)
                entityManager.add(entity: spike)
            case "left":
                let spike = SpikeEntity(position: tilePosition, size: tileSize, xValue: -1, yValue: 1, zRotation: (90 * .pi) / 180 )
                entityManager.add(entity: spike)
            case "right":
                let spike = SpikeEntity(position: tilePosition, size: tileSize, xValue: 1, yValue: 1, zRotation: (-90 * .pi) / 180)
                entityManager.add(entity: spike)
            default:
                break
            }
        case TileType.trapSaw.rawValue:
            let saw = SawEntity(position: tilePosition, size: tileSize)
            entityManager.add(entity: saw)
        case TileType.platform.rawValue :
            let platform = PlatformEntity(position: tilePosition, size: tileSize)
            entityManager.add(entity: platform)
        case TileType.enemy.rawValue:
            let enemy = EnemyEntity(position: tilePosition, size: tileSize)
            entityManager.add(entity: enemy)
        default:
            break
        }
    }
    
}
