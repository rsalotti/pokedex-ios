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
    func fetchPokemonsOfType(name: String) async throws -> PokemonTypeFilter
}

///Fronteira entre a API e o app: decodifica o DTO e devolve sempre o Model final.
///Nenhum DTO atravessa essa camada.
class PokeRepository: Network<PokeAPI>, PokeRepositoryProtocol {
    func fetchRegionPokemons(id: Int) async throws -> Pokedex {
        let dto: PokedexDTO = try await execute(route: .getPokemons(region: id))
        return PokedexMapper.map(dto)
    }

    func fetchSinglePokemon(id: Int) async throws -> Pokemon {
        let dto: PokemonDTO = try await execute(route: .getPokemon(id: id))
        return PokemonMapper.map(dto)
    }

    func fetchSinglePokemonSpecies(id: Int) async throws -> PokemonSpecies {
        let dto: PokemonSpeciesDTO = try await execute(route: .getPokemonSpecies(id: id))
        return PokemonSpeciesMapper.map(dto)
    }

    func fetchAllPokedexRegions() async throws -> PokedexRegion {
        let dto: PokedexRegionDTO = try await execute(route: .getAllPokedexRegions)
        return PokedexRegionMapper.map(dto)
    }

    func fetchPokemonsOfType(name: String) async throws -> PokemonTypeFilter {
        let dto: PokemonTypeDetailDTO = try await execute(route: .getPokemonsOfType(name: name))
        return PokemonTypeFilterMapper.map(dto)
    }
}
