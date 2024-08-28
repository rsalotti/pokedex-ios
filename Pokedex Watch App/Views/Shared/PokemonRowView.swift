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
            Image.getPokemonKantoImage(for: id)
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .padding(.trailing, 8)
            Text(name.capitalizedFirstLetter())
                .font(.title3)
        }
    }
}
