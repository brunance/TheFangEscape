//
//  ShootComponent.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 21/11/23.
//

import Foundation
import GameplayKit

class ShootComponent: GKComponent {
    
    private var shootTimerCounter: TimeInterval = 0.0
    private let shootInterval: TimeInterval = 1.0
    
    var bulletVelocity: CGFloat
    weak var entityManager: SKEntityManager?
    var bullets: [BulletEntity] = []
    
    public init(bulletVelocity: CGFloat, entityManager: SKEntityManager) {
        self.bulletVelocity = bulletVelocity
        self.entityManager = entityManager
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shoot() {
        let bullet = BulletEntity(position: (entity?.component(ofType: GKSKNodeComponent.self)?.node.position)!)
        bullets.append(bullet)
        entityManager?.add(entity: bullet)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        shootTimerCounter += seconds
        
        if shootTimerCounter >= shootInterval {
            shoot()
            shootTimerCounter = 0.0
        }
        
        var indexToRemove: Int?
        for (index, bullet) in bullets.enumerated() {
            if bullet.component(ofType: PhysicsComponent.self)?.touchedOnWall(direction: .right) == true {
                entityManager?.remove(entity: bullet)
                indexToRemove = index
                break
            }
        }
        
        if let index = indexToRemove {
            bullets.remove(at: index)
        }
    }
}

