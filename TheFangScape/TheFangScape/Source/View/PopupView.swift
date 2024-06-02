//
//  PopupView.swift
//  TheFangScape
//
//  Created by Luciano Uchoa on 21/12/23.
//

import Foundation
import SwiftUI

struct PopupView: View {
    
    var homeAction: () -> Void
    var continueAction: () -> Void
    var closeAction: () -> Void
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.clear
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    ZStack {
                        Image("modalBackground")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width / 5, height: geo.size.height / 4)
                        
                        VStack {
                            HStack {
                                Spacer()
                                
                                SecondaryMenuButtons(icon: {
                                    Image("iconClose")
                                }, action: {
                                    closeAction()
                                }, .close)
                            }.padding(.horizontal)
                            
                            Text("Pause")
                                .font(.custom("NovaSquareSlim-Book", size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.lightColor2)
                                .padding(.horizontal)
                            
                            HStack(spacing: 20) {
                                
                                SecondaryMenuButtons(icon: {
                                    Image("iconHome")
                                }, action: {
                                    homeAction()
                                }, .actions)
                                .padding()
                                
                                PrimaryMenuButtons(icon: {
                                    Image("iconReturn")
                                }, action: {
                                    continueAction()
                                }, .actions)
                                .padding()
                            }
                        }
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                    Spacer()
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
