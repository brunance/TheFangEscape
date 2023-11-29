//
//  WallSlide.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 16/11/23.
//

import Foundation
import GameplayKit

class WallSlidingState: GKState {
    
    weak var entity: GKEntity?
    var action: SKAction
    
    init(_ entity: GKEntity, action: SKAction) {
        self.entity = entity
        self.action = action
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if(stateClass is WallSlidingState.Type){return false}
        return true
    }
    
    override func didEnter(from previousState: GKState?) {
        if let node = entity?.component(ofType: GKSKNodeComponent.self)?.node {
            node.run(action)
        }
    }
}

