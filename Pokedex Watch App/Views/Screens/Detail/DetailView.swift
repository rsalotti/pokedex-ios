//
//  DetailView.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 26/08/24.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        TabView {
            VStack {
                Image("001")
                    .resizable()
                    .frame(width: 85, height: 85, alignment: .center)
                Text("Bulbasaur")
                    .font(.title2)
                    .bold()
                HStack(spacing: -5.0) {
                    Image("Grass")
                    Image("Poison")
                }
            }
            Text("Lorem ipsum")
        }
    }
}
