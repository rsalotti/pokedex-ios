//
//  PokemonListView.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 13/08/24.
//

import SwiftUI

struct PokemonListView: View {
    ///Region of Pokemons `2` is the Kanto
    let region: Int = 2
    @StateObject fileprivate var viewModel = PokemonListViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.getPokemons()) { pokemon in
                NavigationLink(destination: PokemonDetailView()) {
                    PokemonRowView(id: pokemon.id, name: pokemon.pokemonSpecies.name)
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchPokemons(by: region)
                }
            }
        }
    }
}
