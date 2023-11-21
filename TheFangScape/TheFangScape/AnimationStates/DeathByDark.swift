//
//  DeathByDark.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 16/11/23.
//

import Foundation
import GameplayKit

class DeathByDark: GKState {
    
    weak var entity: GKEntity?
    
    init(_ entity: GKEntity) {
        self.entity = entity
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if(stateClass is DeathByDark.Type){return false}
        return true
    }
    
    override func didEnter(from previousState: GKState?) {
        let arraySprite = Array<SKTexture>.init(withFormat: "nome_do_asset", range: 1...3)
        if let node = entity?.component(ofType: GKSKNodeComponent.self)?.node{
            node.run(.repeatForever(.animate(with: arraySprite, timePerFrame: 0.15)))
        }
    }
}
