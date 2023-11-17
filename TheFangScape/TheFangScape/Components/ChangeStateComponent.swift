//
//  ChangeStateComponent.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 17/11/23.
//

import Foundation
import GameplayKit

public class ChangeStateComponent: GKComponent {
    
    private var firstState: () -> ()
    private var secondState: () -> ()
    private var isFirstState: Bool
    
    init(firstState: @escaping () -> Void, secondState: @escaping () -> Void) {
        self.firstState = firstState
        self.secondState = secondState
        self.isFirstState = true
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func toogleState() {
        if isFirstState {
            secondState()
        } else {
            firstState()
        }
        isFirstState = !isFirstState
    }
    
}
