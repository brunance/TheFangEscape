//
//  DeathComponent.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 21/11/23.
//

import Foundation
import GameplayKit

class DeathComponent: GKComponent {
    
    weak var physicsComp: PhysicsComponent?
    weak var stateMachineComp: AnimationStateMachineComponent?
    weak var entityManager: SKEntityManager?
    
    init(entityManager: SKEntityManager) {
        self.entityManager = entityManager
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
        physicsComp = entity?.component(ofType: PhysicsComponent.self)
        stateMachineComp = entity?.component(ofType: AnimationStateMachineComponent.self)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        guard let physicsComp = physicsComp else {return}
        
        if physicsComp.touchedOnWall(direction: .right){
            destroyEntity()
        }
    }
    
    private func destroyEntity() {
        if let entityManager = entityManager {
            entityManager.remove(entity: entity!)
        }
    }
}
