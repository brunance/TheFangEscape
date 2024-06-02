//
//  CGPath+Primitives.swift
//  Chiko Liru
//
//  Created by Victor Vasconcelos on 18/10/23.
//

import Foundation
import SpriteKit

extension CGPath {
    
    static func capsule(size: CGSize, 
                        cornerRadius: CGFloat,
                        originOffset: CGPoint = .zero) -> CGPath {
        let path = CGMutablePath()
        
        path.addRoundedRect(in:.init(
                    origin: .init(
                        x: -size.width/2 + originOffset.x,
                        y: -size.height/2 + originOffset.y),
                    size: size),
                            cornerWidth: cornerRadius,
                            cornerHeight: cornerRadius)
        path.closeSubpath()
        
        return path
    }

}
