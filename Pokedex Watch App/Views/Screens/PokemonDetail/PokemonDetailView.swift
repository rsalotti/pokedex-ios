//
//  PokemonDetailView.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 26/08/24.
//

import SwiftUI
import Kingfisher

struct PokemonDetailView: View {
    @StateObject var viewModel: PokemonDetailViewModel
    
    var body: some View {
        TabView {
            if let pokemon = viewModel.pokemon {
                LazyVStack {
                    PKMTypeView(pokemon)
                    PKMDetailView(pokemon)
                }
            } else {
                ProgressView()
            }
            
            if let species = viewModel.pokemonSpecies, let detail = species.flavorTextEntries.first(where: {$0.language.name == "en"}) {
                Text(detail.flavorText)
                    .font(.system(size: 15, weight: .regular))
            }
            
            Text("Tela com os Status")
        }
        .navigationTitle(viewModel.pokemon?.name.capitalizedFirstLetter() ?? "Loading...")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    func PKMTypeView(_ pokemon: Pokemon) -> some View {
        HStack {
            // Types Pokemon
            VStack(spacing: 0) {
                ForEach(pokemon.types, id: \.self) { element in
                    element.type.name.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                }
            }
            // Image Pokemon
            KFImage(URL(string: pokemon.sprites.frontDefault))
                .resizable()
                .scaledToFit()
                .frame(height: 96)
        }
    }
    
    @ViewBuilder
    func PKMDetailView(_ pokemon: Pokemon) -> some View {
        LazyHStack(spacing: 8) {
            VStack(alignment: .leading) {
                Text("Altura")
                    .font(.system(size: 11, weight: .semibold))
                Text(viewModel.getHeightDescription())
                    .font(.system(size: 11, weight: .light))
            }
            VStack(alignment: .leading) {
                Text("Peso")
                    .font(.system(size: 11, weight: .semibold))
                Text(viewModel.getWeightDescription())
                    .font(.system(size: 11, weight: .light))
            }
        }
    }
    
    @ViewBuilder
    func PKMAboutView(_ pokemon: Pokemon) -> some View {
        LazyHStack {
            
        }
    }
    
    @ViewBuilder
    func PKMStatsView(_ pokemon: Pokemon) -> some View {
        
    }
    
}

#Preview {
    PokemonDetailView(viewModel: PokemonDetailViewModel(idPokemon: 6))
}
