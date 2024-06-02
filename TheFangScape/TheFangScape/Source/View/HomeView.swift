//
//  HomeView.swift
//  TheFangScape
//
//  Created by Victor Vasconcelos on 01/12/23.
//

import SwiftUI

struct HomeView: View {
    
    @State private var willMoveToSelection = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.darkWine, .wine]), center: .center, startRadius: 2, endRadius: 650)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Image("GameName")
                        .resizable()
                        .frame(width: 300, height: 395)
                    Spacer()
                    Text("Tap to Scape!")
                        .font(.custom("NovaSquareSlim-Book", size: 24))
                        .foregroundStyle(.white)
                }
            }.onTapGesture {
                willMoveToSelection = true
            }
            .navigationDestination(isPresented: $willMoveToSelection) {
                FloorSelectionView()
            }
        }
    }
}

#Preview {
    HomeView()
}
