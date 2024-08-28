//
//  PokemonDetailView.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 26/08/24.
//

import SwiftUI

struct PokemonDetailView: View {
    @StateObject var viewModel: PokemonDetailViewModel
    
    var body: some View {
        TabView {
            VStack {
                Image.getPokemonKantoImage(for: viewModel.pokemon?.id ?? 1)
                    .resizable()
                    .frame(width: 85, height: 85, alignment: .center)
                Text(viewModel.pokemon?.name.capitalizedFirstLetter() ?? "Unknown")
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
