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
                ScrollView(.vertical, showsIndicators: false) {
                    Text(detail.flavorText)
                        .font(.system(size: 15, weight: .regular))
                }
                .padding(.vertical, 4)
            }
            
        }
        .navigationTitle(viewModel.pokemon?.name.capitalizedFirstLetter() ?? L10n.Common.loading)
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
                Text(L10n.Common.height)
                    .font(.system(size: 11, weight: .semibold))
                Text(viewModel.getHeightDescription())
                    .font(.system(size: 11, weight: .light))
            }
            VStack(alignment: .leading) {
                Text(L10n.Common.weight)
                    .font(.system(size: 11, weight: .semibold))
                Text(viewModel.getWeightDescription())
                    .font(.system(size: 11, weight: .light))
            }
            VStack(alignment: .leading) {
                Text(L10n.Common.baseLevel)
                    .font(.system(size: 11, weight: .semibold))
                Text("\(pokemon.baseExperience)")
                    .font(.system(size: 11, weight: .light))
            }
        }
    }
    
    @ViewBuilder
    func PKMStatsView(_ pokemon: Pokemon) -> some View {
        LazyVStack(alignment: .leading, spacing: 1) {
            ProgressBarView(title: L10n.Pokemon.hp, value: viewModel.statHPValue, barColor: viewModel.barColor)
            ProgressBarView(title: L10n.Pokemon.attack, value: viewModel.statAttackValue, barColor: viewModel.barColor)
            ProgressBarView(title: L10n.Pokemon.defense, value: viewModel.statDefenseValue, barColor: viewModel.barColor)
            ProgressBarView(title: L10n.Pokemon.sattack, value: viewModel.statSAttackValue, barColor: viewModel.barColor)
            ProgressBarView(title: L10n.Pokemon.sdefense, value: viewModel.statSDefenseValue, barColor: viewModel.barColor)
            ProgressBarView(title: L10n.Pokemon.speed, value: viewModel.statSpeedValue, barColor: viewModel.barColor)
        }
        .padding(20)
    }
    
}

#Preview {
    PokemonDetailView(viewModel: PokemonDetailViewModel(idPokemon: 6))
}
