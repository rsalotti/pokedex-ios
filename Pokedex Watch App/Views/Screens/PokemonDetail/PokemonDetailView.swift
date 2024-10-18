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
            LazyVStack {
                if let pokemon = viewModel.pokemon {
                    Image.getPokemonKantoImage(for: pokemon.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 85)
                    PKMTypeView(pokemon)
                } else {
                    Text("No Pokémon data available")
                }
            }
            .padding()
            Text("Lorem ipsum")
        }
        .navigationTitle(viewModel.pokemon?.name.capitalizedFirstLetter() ?? "Loading...")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    func PKMTypeView(_ pokemon: Pokemon) -> some View {
        LazyHStack(spacing: 0) {
            ForEach(pokemon.types, id: \.self) { element in
                element.type.name.image
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
    
    @ViewBuilder
    func PKMDetails(_ pokemon: Pokemon) -> some View {
        LazyVStack {
            
        }
    }
}
