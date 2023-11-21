//
//  RemoveWhenTouchWall.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 21/11/23.
//

import Foundation
import GameplayKit

public class RemoveWhenTouchWall: GKComponent {
    
    weak var physicsComp: PhysicsComponent?
    weak var moveComp: MovementComponent?
    weak var node: SKNode?
    
    public override func didAddToEntity() {
        physicsComp = entity?.component(ofType: PhysicsComponent.self)
        moveComp = entity?.component(ofType: MovementComponent.self)
        node = entity?.component(ofType: GKSKNodeComponent.self)?.node
    }
    
    public override func update(deltaTime seconds: TimeInterval) {
        guard let physicsComp, let moveComp else { return }
        
        if physicsComp.touchedOnWall(direction: moveComp.direction) {
            removeBullet()
        }
    }
    
    
    private func removeBullet() {
        guard let physicsComp, let moveComp else { return }
                
        physicsComp.body.affectedByGravity = true

        physicsComp.body.applyImpulse(.init(
            dx: -moveComp.direction.rawValue * 0.2,
            dy: 0))
        
        guard let scene = node?.scene as? GameScene else { return }

        let sequence = SKAction.sequence([.wait(forDuration: 0.15)])
        node?.run(sequence) {
            guard let entity = self.entity else { return }
            scene.entityManager?.remove(entity: entity)
        }
    }
}
