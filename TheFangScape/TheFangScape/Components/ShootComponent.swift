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
    private let shootInterval: TimeInterval = 0.5
    
    var bulletVelocity: CGFloat
    var bulletDirection: PlayerDirection
    weak var entityManager: SKEntityManager?
    var currentBullet: BulletEntity?
    
    public init(bulletVelocity: CGFloat, entityManager: SKEntityManager, bulletDirection: PlayerDirection) {
        self.bulletVelocity = bulletVelocity
        self.entityManager = entityManager
        self.bulletDirection = bulletDirection
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shoot() {
        
        let bullet = BulletEntity(position: (entity?.component(ofType: GKSKNodeComponent.self)?.node.position)!, bulletDirection: bulletDirection)
        entityManager?.add(entity: bullet)
        
        currentBullet = bullet
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        shootTimerCounter += seconds
        
        if shootTimerCounter >= shootInterval {
            guard let currentBullet = currentBullet else {
                shoot()
                return
            }
            shootTimerCounter = 0.0
        }
        
        if let bullet = currentBullet {
            if bullet.component(ofType: PhysicsComponent.self)?.touchedOnWall(direction: bulletDirection) == true {
                entityManager?.remove(entity: bullet)
                currentBullet = nil
            }
        }
    }
}


