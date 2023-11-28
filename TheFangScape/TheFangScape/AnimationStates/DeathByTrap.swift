//
//  DeathByTrao.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 16/11/23.
//

import Foundation
import GameplayKit

class DeathByTrap: GKState {
    
    weak var entity: GKEntity?
    
    init(_ entity: GKEntity) {
        self.entity = entity
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return false
    }
    
    override func didEnter(from previousState: GKState?) {
        let arraySprite = Array<SKTexture>.init(withFormat: "playerDeathByTrap%@", range: 1...14)
        if let node = entity?.component(ofType: GKSKNodeComponent.self)?.node{
            node.run(.repeatForever(.animate(with: arraySprite, timePerFrame: 0.15)))
        }
    }
}
