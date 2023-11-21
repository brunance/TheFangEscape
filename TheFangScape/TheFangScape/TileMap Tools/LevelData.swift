//
//  LevelData.swift
//  Chiko Liru
//
//  Created by Victor Vasconcelos on 19/10/23.
//

import Foundation

public struct LevelData: Codable {
    let layers: [LayerData]
    let tilewidth: Int
    let tileheight: Int
    var tileSize: CGSize {
        return .init(width: tilewidth, height: tileheight)
    }
}

public struct LayerData: Codable {
    let name: String
    let data: [Int]
    let height: Int
    let width: Int
    let properties: [LayerProperty]?
    var isNotRendered: Bool
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.data = try container.decode([Int].self, forKey: .data)
        self.height = try container.decode(Int.self, forKey: .height)
        self.width = try container.decode(Int.self, forKey: .width)
        self.properties = try container.decodeIfPresent([LayerProperty].self, forKey: .properties)
        self.isNotRendered = properties?.contains(where: { propety in
            return propety.name == "isNotRendered"
        }) ?? false
    }
}

public struct LayerProperty: Codable {
    let name: String
    let value: String
}
