//
//  PhysicsComponent.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 14/11/23.
//

import Foundation
import GameplayKit
import SpriteKit

public class PhysicsComponent: GKComponent {
    
    public var body: SKPhysicsBody
    
    private weak var node: SKNode?
    private var physicsWorld: SKPhysicsWorld?
    
    init(body: SKPhysicsBody) {
        self.body = body
        super.init()
    }
    
    public static func rectangleBody(ofSize size: CGSize) -> PhysicsComponent {
        let body = SKPhysicsBody(rectangleOf: size)
        body.linearDamping = 0.5
        body.restitution = 0.0
        body.allowsRotation = false
        return PhysicsComponent(body: body)
    }
    
    public static func circle(ofRadius radius: CGFloat) -> PhysicsComponent {
        let body = SKPhysicsBody(circleOfRadius: radius)
        body.linearDamping = 0.5
        body.restitution = 0.0
        body.allowsRotation = false
        return PhysicsComponent(body: body)
    }
    
    public static func capsule(size: CGSize, cornerRadius: CGFloat) -> PhysicsComponent {
        let body = SKPhysicsBody(polygonFrom: .capsule(size: size, cornerRadius: cornerRadius))
        body.linearDamping = 0.5
        body.restitution = 0.0
        body.allowsRotation = false
        return PhysicsComponent(body: body)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didAddToEntity() {
        guard let node = self.entity?.component(ofType: GKSKNodeComponent.self)?.node else {
            fatalError("Should has a Node to use this component")
        }
        node.physicsBody = body
        self.node = node
    }
    
    public func isOnGround() -> Bool {
        guard let node else { return false }
        let height = node.calculateAccumulatedFrame().size.height
        let rayDistance = CGPoint(x: node.position.x,
                                  y: node.position.y - (height/2) - 10)
        
        return raycast(checkFor: IsGroundComponent.self,
                       rayDistance: rayDistance)
    }
    
    public func touchedOnWall(direction: Direction) -> Bool {
        guard let node else { return false }
        
        let width = node.calculateAccumulatedFrame().size.width
        
        let rayDistance = CGPoint(x: node.position.x + (width / 2 + 1) * direction.rawValue, y: node.position.y)
        return raycast(checkFor: IsWallComponent.self,
                       rayDistance: rayDistance)
    }
    
    public func isWallSliding(direction: Direction) -> Bool  {
        return touchedOnWall(direction: direction) && !isOnGround()
    }
    
    private func raycast(checkFor type: GKComponent.Type, rayDistance: CGPoint) -> Bool {
        guard let node else { return false }
        
        var check = false
        
        if physicsWorld == nil, let physicsWorld = body.node?.scene?.physicsWorld {
            self.physicsWorld = physicsWorld
        }
        
        let _ = physicsWorld?.enumerateBodies(alongRayStart: node.position , end: rayDistance, using: { body, _, _, _ in
            // Check if the body founded has Ground Component
            if body.node?.entity?.component(ofType: type) != nil {
                check = true
            }
        })
        
#if DEBUG
        let path = CGMutablePath()
        path.move(to: node.position)
        path.addLine(to: rayDistance)
        let debugNode = SKShapeNode(path: path)
        debugNode.strokeColor = check ? .green : .red
        debugNode.lineWidth = 5
        node.scene?.addChild(debugNode)
        debugNode.run(.sequence([
            .wait(forDuration: 0.3),
            .removeFromParent()
        ]))
#endif
        return check
    }
    
    public func isActive(_ value: Bool = true) {
        self.node?.physicsBody = value ? body : nil
    }
}
