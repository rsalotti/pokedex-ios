//
//  PokemonListViewModel.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 27/08/24.
//

import Foundation

class PokemonListViewModel: ObservableObject {
    @Published var pokedex: Pokedex? = nil
    
    func fetchPokemons(by region: Int) async {
        do {
            let pokedex = try await PokeRepository().getPokemons(id: region)
            DispatchQueue.main.async {
                self.pokedex = pokedex
            }
        } catch let error {
            //TODO: - Resolver o problema caso dê erro.
            print(error.localizedDescription)
        }
    }
    
    func getPokemons() -> [PKDPokemonEntry] {
        guard let pokemonEntries = pokedex?.pokemonEntries else {
            return []
        }
        return pokemonEntries
    }
}
