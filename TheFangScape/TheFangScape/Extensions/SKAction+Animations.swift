//
//  SKAction+Animations.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 21/11/23.
//

import Foundation
import SpriteKit

extension SKAction {
    public static func playerRun() -> SKAction {
        return .repeatForever(.animate(with: .init(withFormat: "playerRun%@", range: 1...8), timePerFrame: 0.1))
    }
    
    public static func playerJump() -> SKAction {
        return .repeatForever(.animate(with: .init(withFormat: "playerJump%@", range: 1...2), timePerFrame: 0.5))
    }
    
    public static func playerWallSlide() -> SKAction {
        return .repeatForever(.animate(with: .init(withFormat: "playerWallSlide%@", range: 1...1), timePerFrame: 1))
    }
}
