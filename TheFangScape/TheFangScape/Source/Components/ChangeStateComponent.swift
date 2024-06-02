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
    var isFirstState: Bool
    
    init(firstState: @escaping () -> Void, secondState: @escaping () -> Void, isFirstState: Status) {
        self.firstState = firstState
        self.secondState = secondState
        self.isFirstState = isFirstState.rawValue == 1.0 ? true : false
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
