//
//  DestructableComponent.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 23/11/23.
//

import Foundation
import GameplayKit


public class DestructableComponent: GKComponent {
    
    weak var node: SKNode?
    
    public override func didAddToEntity() {
        node = entity?.component(ofType: GKSKNodeComponent.self)?.node
    }
    
    public func destroy() {
        guard let entityManager = (node?.scene as? GameScene)?.entityManager,
        let entity else { return }
        entityManager.remove(entity: entity)
    }
    
}
