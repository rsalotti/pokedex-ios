//
//  PokemonHomeViewModel.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 27/08/24.
//

import Foundation

@MainActor
class PokemonHomeViewModel: ObservableObject {
    @Published var allPokemons: Pokedex?
    var allPokedexRegions: PokedexRegion?
    
    init() {
        //Tarefa Async logo após iniciar todas as variáveis.
        Task {
            async let pokemons: () = fetchAllPokemons()
            async let allPokedexRegions: () = fetchAllPokedexRegions()
            // O Await espera as 2 chamadas acima serem finalizadas.
            _ = await (pokemons, allPokedexRegions)
        }
    }
    
    /**
     All Public Methods
     */
    func getPokemons() -> [PKDPokemonEntry] {
        guard let pokemonEntries = allPokemons?.pokemonEntries else {
            return []
        }
        return pokemonEntries
    }
    
    /**
     All Private Methods
     */
    private func fetchAllPokemons() async {
        do {
            ///All Pokemons in National Pokedex 1025 Entries
            let national: Int = 1
            self.allPokemons = try await PokeRepository().fetchRegionPokemons(id: national)
        } catch let error {
            //TODO: - Resolver o problema caso dê erro.
            print(error.localizedDescription)
        }
    }
    
    private func fetchAllPokedexRegions() async {
        do {
            self.allPokedexRegions = try await PokeRepository().fetchAllPokedexRegions()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
