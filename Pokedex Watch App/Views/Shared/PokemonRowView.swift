//
//  PokemonRowView.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 26/08/24.
//

import SwiftUI

struct PokemonRowView: View {
    var id: Int
    var name: String
    
    var body: some View {
        HStack {
            Image(uiImage: Asset._001.image)
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .padding(5)
            Text(name)
                .font(.title3)
        }
    }
}
