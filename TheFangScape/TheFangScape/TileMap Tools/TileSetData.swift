//
//  TileSetData.swift
//  Chiko Liru
//
//  Created by Victor Vasconcelos on 19/10/23.
//

import Foundation
import SpriteKit

public struct TileSetData: Codable {
    var name: String
    var tiles: [Tile]
    
    subscript(index: Int) -> Tile? {
        get {
            guard index >= 0 && index < tiles.count else { return nil }
            return tiles[index]
        }
    }
    
    func getTileDefinition(at: Int) -> SKTileDefinition? {
        guard at >= 0 && at < tiles.count else { return nil }
        guard let tile = self[at] else { return nil }
        let texture = SKTexture(imageNamed: tile.getImageNamed())
        let tileDef = SKTileDefinition(texture: texture)
        tileDef.userData = tile.userData
        
        return tileDef
    }
    
    func getSKTileSet(fromIds ids: [Int]) -> SKTileSet {
        
        var done = Set<Int>()
        var groups: [SKTileGroup] = []
        
        for id in ids {
            if(done.contains(id)) { continue }
            
            if let tileDef = getTileDefinition(at: id) {
                let group = SKTileGroup(tileDefinition: tileDef)
                groups.append(group)
            }
            
            done.insert(id)
        }

        return SKTileSet(tileGroups: groups)
    }
}

public struct Tile: Codable {
    var id: Int
    var image: String
    var properties: [TileSetProperty]?
    var type: String?
    
    func getImageNamed() -> String {
        var result = ""
        
        result = "\(image.split(separator: "/").last ?? "")"
        
        if let dotRange = result.range(of: ".") {
            return String(result.prefix(upTo: dotRange.lowerBound))
        }
        
        return result
    }
    
    var userData: NSMutableDictionary? {
        guard let properties else { return nil }
        let result: NSMutableDictionary = [:]
        for property in properties {
            result[property.name] = property.value
        }
        return result
    }
}

public struct TileSetProperty: Codable {
    var name: String
    var type: String
    var value: String
}
