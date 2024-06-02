//
//  MenuButtons.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 21/12/23.
//

import Foundation
import SwiftUI

enum ButtonType {
    case actions
    case close
}

struct PrimaryMenuButtons: View {
    
    var icon: Image
    var action: (() -> Void)
    var type: ButtonType
    
    @Environment(\.isEnabled) var isEnabled
    
    var body: some View {
        
        Button {
            action()
        } label: {
            icon
                .resizable()
                .frame(width: type == .actions ? 32 : 13, height: type == .actions ? 32 : 13)
        }
        .frame(width: type == .actions ? 79 : 32, height:  type == .actions ? 82 : 32)
        .buttonStyle(PrimaryMenuButtonStyle(isEnabled: isEnabled))
    }
    
    public init(@ViewBuilder icon: () -> Image,
                action: @escaping() -> Void,
                _ type: ButtonType) {
        self.icon = icon()
        self.action = action
        self.type = type
    }
}

struct SecondaryMenuButtons: View {
    
    var icon: Image
    var action: (() -> Void)
    var type: ButtonType
    
    @Environment(\.isEnabled) var isEnabled
    
    var body: some View {
        
        Button {
            action()
        } label: {
            icon
                .resizable()
                .frame(width: type == .actions ? 32 : 13, height: type == .actions ? 32 : 13)
        }
        .frame(width: type == .actions ? 79 : 32, height:  type == .actions ? 82 : 32)
        .buttonStyle(SecondaryMenuButtonStyle(isEnabled: isEnabled))
    }
    
    public init(@ViewBuilder icon: () -> Image,
                action: @escaping() -> Void,
                _ type: ButtonType) {
        self.icon = icon()
        self.action = action
        self.type = type
    }
}

private struct PrimaryMenuButtonStyle: ButtonStyle {
    let isEnabled: Bool
    
    @ViewBuilder
    func makeBody(configuration: Configuration) -> some View {
        let background = Image(.buttonBackgroundPressed)
        let scale = configuration.isPressed ? 1.1 : 1.0
        
        ZStack {
            background
                .resizable()
            configuration.label
                .cornerRadius(8)
        }.scaleEffect(CGSize(width: scale, height: scale))
    }
}

private struct SecondaryMenuButtonStyle: ButtonStyle {
    let isEnabled: Bool
    
    @ViewBuilder
    func makeBody(configuration: Configuration) -> some View {
        let background = Image(.buttonBackground)
        let scale = configuration.isPressed ? 1.1 : 1.0
        
        ZStack {
            background
                .resizable()
            configuration.label
                .cornerRadius(8)
        }.scaleEffect(CGSize(width: scale, height: scale))
    }
}
