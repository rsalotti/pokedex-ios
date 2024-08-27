//
//  PokeRepository.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 26/08/24.
//

import Foundation

protocol PokeRepositoryProtocol {
    func getPokemons(id: Int) async throws -> Pokedex
}

class PokeRepository: Network<PokeAPI>, PokeRepositoryProtocol {
    @discardableResult
    func getPokemons(id: Int) async throws -> Pokedex {
        let route = PokeAPI.getPokemons(region: id)
        return try await execute(route: route)
    }
}
