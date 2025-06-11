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
                PKMStatsView(pokemon)
            } else {
                ProgressView()
            }
            
            if let species = viewModel.pokemonSpecies, let detail = species.flavorTextEntries.first(where: {$0.language.name == "en"}) {
                Text(detail.flavorText)
                    .font(.system(size: 15, weight: .regular))
            }
            
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
                Text("Height")
                    .font(.system(size: 11, weight: .semibold))
                Text(viewModel.getHeightDescription())
                    .font(.system(size: 11, weight: .light))
            }
            VStack(alignment: .leading) {
                Text("Weight")
                    .font(.system(size: 11, weight: .semibold))
                Text(viewModel.getWeightDescription())
                    .font(.system(size: 11, weight: .light))
            }
        }
    }
    
    @ViewBuilder
    func PKMStatsView(_ pokemon: Pokemon) -> some View {
        LazyVStack(alignment: .leading, spacing: 1) {
            ProgressBarView(title: "HP", value: CGFloat(pokemon.stats.first(where: {$0.stat.name == "hp"})?.baseStat ?? 0), barColor: pokemon.types.first?.type.name.color ?? .bug)
            ProgressBarView(title: "Attack", value: CGFloat(pokemon.stats.first(where: {$0.stat.name == "attack"})?.baseStat ?? 0), barColor: pokemon.types.first?.type.name.color ?? .bug)
            ProgressBarView(title: "Defense", value: CGFloat(pokemon.stats.first(where: {$0.stat.name == "defense"})?.baseStat ?? 0), barColor: pokemon.types.first?.type.name.color ?? .bug)
            ProgressBarView(title: "S.Attack", value: CGFloat(pokemon.stats.first(where: {$0.stat.name == "special-attack"})?.baseStat ?? 0), barColor: pokemon.types.first?.type.name.color ?? .bug)
            ProgressBarView(title: "S.Defense", value: CGFloat(pokemon.stats.first(where: {$0.stat.name == "special-defense"})?.baseStat ?? 0), barColor: pokemon.types.first?.type.name.color ?? .bug)
            ProgressBarView(title: "Speed", value: CGFloat(pokemon.stats.first(where: {$0.stat.name == "speed"})?.baseStat ?? 0), barColor: pokemon.types.first?.type.name.color ?? .bug)
        }
        .padding(20)
    }
    
}

#Preview {
    PokemonDetailView(viewModel: PokemonDetailViewModel(idPokemon: 6))
}
