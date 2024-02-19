//
//  ContentView.swift
//  NeuroParasite
//
//  Created by Dorothy Luetz on 12/15/23.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    NavigationLink {
                        SillyView()
                    } label: {
                        Text("Stonordstrom")
                    }
                    NavigationLink {
                        GameView()
                    } label: {
                        Text("Plunge")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
