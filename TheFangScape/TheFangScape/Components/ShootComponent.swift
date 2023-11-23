//
//  ShootComponent.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 21/11/23.
//

import Foundation
import GameplayKit

class ShootComponent: GKComponent {
    
    weak var entityManager: SKEntityManager?
    weak var node: SKNode?
    
    private var shootTimerCounter: TimeInterval = 0.0
    private let shootInterval: TimeInterval = 0.5
    
    var bulletDirection: Direction
    
    public init(entityManager: SKEntityManager, bulletDirection: Direction) {
        self.entityManager = entityManager
        self.bulletDirection = bulletDirection
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
        node = entity?.component(ofType: GKSKNodeComponent.self)?.node
    }
    
    func shoot() {
        
        guard let node = node else { return }
        
        let bullet = BulletEntity(position: node.position, bulletDirection: bulletDirection)
        entityManager?.add(entity: bullet)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        shootTimerCounter += seconds
        
        if shootTimerCounter >= shootInterval {
            shoot()
            shootTimerCounter = 0.0
        }
    }
}


