//
//  PokemonListView.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 13/08/24.
//

import SwiftUI

struct PokemonListView: View {
    //Region of Pokemons '2' is the Kanto
    let region: Int = 2
    let regionName: String = "Kanto"
    @StateObject var viewModel = PokemonListViewModel()
    @State var isLoading: Bool = true
    
    var body: some View {
        NavigationView {
            ZStack {
                List(viewModel.getPokemons()) { pokemon in
                    let destination = PokemonDetailView(viewModel: PokemonDetailViewModel(idPokemon: pokemon.id))
                    NavigationLink(destination: destination) {
                        PKMRowView(pokemon)
                    }
                }
                .navigationTitle(regionName)
                if isLoading {
                    List {
                        SkeletonCellView()
                        SkeletonCellView()
                        SkeletonCellView()
                        SkeletonCellView()
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchRegionPokemons(by: region)
                    isLoading = false
                }
            }
        }
    }
    
    @ViewBuilder
    func PKMRowView(_ pokemon: PKDPokemonEntry) -> some View {
        HStack {
            Image.getPokemonKantoImage(for: pokemon.id)
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .padding(.trailing, 8)
            Text(pokemon.pokemonSpecies.name.capitalizedFirstLetter())
                .font(.title3)
                .lineLimit(1)
        }
    }
}
