//
//  PokeRepository.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 26/08/24.
//

import Foundation

protocol PokeRepositoryProtocol {
    func fetchRegionPokemons(id: Int) async throws -> Pokedex
    func fetchSinglePokemon(id: Int) async throws -> Pokemon
    func fetchSinglePokemonSpecies(id: Int) async throws -> PokemonSpecies
    func fetchAllPokedexRegions() async throws -> PokedexRegion
}

class PokeRepository: Network<PokeAPI>, PokeRepositoryProtocol {
    func fetchRegionPokemons(id: Int) async throws -> Pokedex {
        let route = PokeAPI.getPokemons(region: id)
        return try await execute(route: route)
    }
    
    func fetchSinglePokemon(id: Int) async throws -> Pokemon {
        let route = PokeAPI.getPokemon(id: id)
        return try await execute(route: route)
    }
    
    func fetchSinglePokemonSpecies(id: Int) async throws -> PokemonSpecies {
        let route = PokeAPI.getPokemonSpecies(id: id)
        return try await execute(route: route)
    }
    
    func fetchAllPokedexRegions() async throws -> PokedexRegion {
        let route = PokeAPI.getAllPokedexRegions
        return try await execute(route: route)
    }
}
