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
                PKMStatsView()

                if let description = viewModel.description {
                    ScrollView(.vertical, showsIndicators: false) {
                        Text(description)
                            .font(.system(size: 15, weight: .regular))
                    }
                    .padding(.vertical, 4)
                }
            } else if viewModel.state == .failed {
                errorView
            } else {
                ProgressView()
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadIfNeeded()
        }
    }

    private var errorView: some View {
        VStack(spacing: 8) {
            Image(systemName: "exclamationmark.triangle")
                .font(.title3)
            Text(L10n.Error.loadFailed)
                .font(.footnote)
                .multilineTextAlignment(.center)
            Button(L10n.Common.retry) {
                Task { await viewModel.retry() }
            }
        }
        .padding()
    }

    @ViewBuilder
    func PKMTypeView(_ pokemon: Pokemon) -> some View {
        HStack {
            // Types Pokemon
            VStack(spacing: 0) {
                ForEach(pokemon.types, id: \.self) { type in
                    type.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                        .accessibilityLabel(type.title)
                }
            }
            // Image Pokemon
            KFImage(pokemon.artworkURL)
                .setProcessor(DownsamplingImageProcessor(size: CGSize(width: 96, height: 96)))
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
    func PKMStatsView() -> some View {
        LazyVStack(alignment: .leading, spacing: 1) {
            ForEach(viewModel.stats) { stat in
                ProgressBarView(
                    title: stat.title,
                    value: CGFloat(stat.baseValue),
                    maxValue: PokemonStatKind.maxBaseValue,
                    barColor: viewModel.barColor
                )
            }
        }
        .padding(20)
    }
}

#Preview {
    PokemonDetailView(viewModel: PokemonDetailViewModel(idPokemon: 6))
}
