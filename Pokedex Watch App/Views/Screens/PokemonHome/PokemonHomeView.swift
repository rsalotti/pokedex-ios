//
//  PokemonHomeView.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 13/08/24.
//

import SwiftUI
import Kingfisher

struct PokemonHomeView: View {
    @StateObject var viewModel = PokemonHomeViewModel()
    @State var showFilter: Bool = false

    ///Quantidade de células fantasma exibidas enquanto a Pokédex carrega.
    private let skeletonCount: Int = 6

    var body: some View {
        NavigationStack {
            ZStack {
                switch viewModel.state {
                case .loading:
                    skeletonList
                case .failed:
                    errorView
                case .loaded:
                    pokemonList
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: {
                        showFilter.toggle()
                    }) {
                        filterIcon
                    }
                    .accessibilityLabel(L10n.Filter.title)
                }
            }
            .fullScreenCover(isPresented: $showFilter) {
                PokemonTypeView(selectedType: viewModel.selectedType) { type in
                    Task { await viewModel.selectType(type) }
                }
            }
            .task {
                await viewModel.loadIfNeeded()
            }
        }
    }

    ///Mostra o tipo ativo no lugar do ícone padrão para o filtro não ficar invisível.
    @ViewBuilder
    private var filterIcon: some View {
        if let selectedType = viewModel.selectedType {
            selectedType.image
                .resizable()
                .frame(width: 20, height: 20)
        } else {
            Image(systemName: "list.bullet")
        }
    }

    @ViewBuilder
    private var pokemonList: some View {
        let pokemons = viewModel.getPokemons()
        if pokemons.isEmpty {
            emptyView
        } else {
            List(pokemons) { pokemon in
                let destination = PokemonDetailView(viewModel: PokemonDetailViewModel(idPokemon: pokemon.id))
                NavigationLink(destination: destination) {
                    PKMRowView(pokemon)
                }
            }
        }
    }

    private var skeletonList: some View {
        List(0..<skeletonCount, id: \.self) { _ in
            SkeletonCellView()
        }
        .accessibilityLabel(L10n.Common.loading)
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

    private var emptyView: some View {
        VStack(spacing: 8) {
            Text(L10n.Error.emptyFilter)
                .font(.footnote)
                .multilineTextAlignment(.center)
            Button(L10n.Filter.clear) {
                Task { await viewModel.selectType(nil) }
            }
        }
        .padding()
    }

    @ViewBuilder
    func PKMRowView(_ pokemon: PokedexEntry) -> some View {
        HStack {
            KFImage(pokemon.spriteURL)
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
                .padding(.trailing, 8)
            Text(pokemon.displayName)
                .font(.title3)
                .lineLimit(1)
        }
    }
}

#Preview {
    PokemonHomeView(viewModel: PokemonHomeViewModel())
}
