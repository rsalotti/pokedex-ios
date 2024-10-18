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
}

class PokeRepository: Network<PokeAPI>, PokeRepositoryProtocol {
    @discardableResult
    func fetchRegionPokemons(id: Int) async throws -> Pokedex {
        let route = PokeAPI.getPokemons(region: id)
        return try await execute(route: route)
    }
    
    @discardableResult
    func fetchSinglePokemon(id: Int) async throws -> Pokemon {
        let route = PokeAPI.getPokemon(id: id)
        return try await execute(route: route)
    }
}
