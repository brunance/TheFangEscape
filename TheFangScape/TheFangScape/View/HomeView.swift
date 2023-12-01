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
                Color.homeBackground
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Image("GameName")
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
