//
//  RoomButtonNode.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 01/12/23.
//

import Foundation
import SpriteKit

public class RoomButtonNode: ButtonNode {
    var isLocked: Bool = false {
        didSet {
            alpha = isLocked ? 0.3 : 1
            isUserInteractionEnabled = !isLocked
        }
    }
}

public class FloorButtonNode: ButtonNode {
    var isLocked: Bool = false {
        didSet {
            alpha = isLocked ? 0.3 : 1
            isUserInteractionEnabled = !isLocked
        }
    }
}
