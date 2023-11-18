//
//  ChangeStateBlockEntity.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 17/11/23.
//

import Foundation
import GameplayKit

public class ChangeStateBlockEntity: BlockEntity {
    
    public override init(position: CGPoint = .zero) {
        super.init(position: position)
        
        guard let physicsComp = self.component(ofType: PhysicsComponent.self),
              let node = self.component(ofType: GKSKNodeComponent.self)?.node
        else { return }
        
        let changeStateComp = ChangeStateComponent {
            node.alpha = 1
            physicsComp.isActive()
        } secondState: {
            node.alpha = 0.4
            physicsComp.isActive(false)
        }

        self.addComponent(changeStateComp)
        
        NotificationCenter.default.addObserver(self, selector: #selector(observeJump), name: .jumped, object: nil)
    }
    
    @objc
    private func observeJump() {
        component(ofType: ChangeStateComponent.self)?.toogleState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
