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
    
    private var shootTimerCounter: TimeInterval = 0.0
    private let shootInterval: TimeInterval = 0.5
    
    var bulletVelocity: CGFloat
    var bulletDirection: PlayerDirection
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
            guard let _ = currentBullet else {
                shoot()
                return
            }
            shootTimerCounter = 0.0
        }
        
        if let bullet = currentBullet {
            if bullet.component(ofType: PhysicsComponent.self)?.touchedOnWall(direction: bulletDirection) == true {
                removeBullet(bullet)
            }
        }
    }
    
    private func removeBullet(_ bullet: BulletEntity) {
        
        bullet.removeComponent(ofType: MovementComponent.self)
        bullet.component(ofType: PhysicsComponent.self)?.body.affectedByGravity = true
        bullet.component(ofType: PhysicsComponent.self)?.body.applyImpulse(CGVector(dx: -self.bulletDirection.rawValue * 0.1, dy: 0))
        
        let appearAction = SKAction.scale(to: 1.5, duration: 0.2)
        let disappearAction = SKAction.scale(to: 0, duration: 0.2)
        let removeAction = SKAction.removeFromParent()
        
        let visualEffectNode = SKSpriteNode(color: .white, size: CGSize(width: 10, height: 10))
        
        bullet.component(ofType: GKSKNodeComponent.self)?.node.addChild(visualEffectNode)
        
        let sequence = SKAction.sequence([appearAction, disappearAction, removeAction])
        visualEffectNode.run(sequence) {
            self.entityManager?.remove(entity: bullet)
            self.currentBullet = nil
        }
    }
}


