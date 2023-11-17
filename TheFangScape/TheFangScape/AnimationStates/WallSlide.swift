//
//  WallSlide.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 16/11/23.
//

import Foundation
import GameplayKit

class WallSlide: GKState {
    
    weak var entity: PlayerEntity?
    
    init(_ entity: PlayerEntity) {
        self.entity = entity
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if(stateClass is WallSlide.Type){return false}
        return true
    }
    
    override func didEnter(from previousState: GKState?) {
        let arraySprite = Array<SKTexture>.init(withFormat: "WallSlide", range: 1...1)
        if let node = entity?.component(ofType: GKSKNodeComponent.self)?.node{
            node.run(.repeatForever(.animate(with: arraySprite, timePerFrame: 0.15)))
        }
    }
}

