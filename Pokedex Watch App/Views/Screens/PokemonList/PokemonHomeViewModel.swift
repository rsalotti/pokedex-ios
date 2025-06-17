//
//  PokemonHomeViewModel.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 27/08/24.
//

import Foundation

class PokemonHomeViewModel: ObservableObject {
    @Published var pokedex: Pokedex? = nil
    
    var regionNumber: Int {
        return 1
    }
    
    var regionTitle: String {
        return ""
    }
    
    init(pokedex: Pokedex? = nil) {
        Task {
            await fetchRegionPokemons(by: regionNumber)
        }
    }
    
    func fetchRegionPokemons(by region: Int) async {
        do {
            let pokedex = try await PokeRepository().fetchRegionPokemons(id: region)
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
