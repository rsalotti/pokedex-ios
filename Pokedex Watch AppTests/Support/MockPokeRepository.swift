//
//  MockPokeRepository.swift
//  Pokedex Watch AppTests
//
//  Created by Ricardo Salotti on 19/08/25.
//

import Foundation
@testable import Pokedex_Watch_App

///Dublê do repositório: guarda o que devolver e conta quantas vezes cada rota foi chamada,
///para os testes conseguirem afirmar que a ViewModel não refaz requisições à toa.
final class MockPokeRepository: PokeRepositoryProtocol {
    enum StubError: Error {
        case semRede
    }

    var pokedexResult: Result<Pokedex, Error> = .failure(StubError.semRede)
    var pokemonResult: Result<Pokemon, Error> = .failure(StubError.semRede)
    var speciesResult: Result<PokemonSpecies, Error> = .failure(StubError.semRede)
    var regionsResult: Result<PokedexRegion, Error> = .failure(StubError.semRede)
    var typeFilterResult: Result<PokemonTypeFilter, Error> = .failure(StubError.semRede)

    private(set) var pokedexCallCount = 0
    private(set) var pokemonCallCount = 0
    private(set) var speciesCallCount = 0
    private(set) var regionsCallCount = 0
    private(set) var typeFilterCallCount = 0
    private(set) var requestedTypeNames: [String] = []
    private(set) var requestedPokemonIDs: [Int] = []

    func fetchRegionPokemons(id: Int) async throws -> Pokedex {
        pokedexCallCount += 1
        return try pokedexResult.get()
    }

    func fetchSinglePokemon(id: Int) async throws -> Pokemon {
        pokemonCallCount += 1
        requestedPokemonIDs.append(id)
        return try pokemonResult.get()
    }

    func fetchSinglePokemonSpecies(id: Int) async throws -> PokemonSpecies {
        speciesCallCount += 1
        return try speciesResult.get()
    }

    func fetchAllPokedexRegions() async throws -> PokedexRegion {
        regionsCallCount += 1
        return try regionsResult.get()
    }

    func fetchPokemonsOfType(name: String) async throws -> PokemonTypeFilter {
        typeFilterCallCount += 1
        requestedTypeNames.append(name)
        return try typeFilterResult.get()
    }
}

///Atalhos para montar models finais nos testes de ViewModel, onde o JSON não interessa.
enum ModelBuilder {
    static func pokedexEntry(id: Int, name: String) -> PokedexEntry {
        return PokedexEntry(
            id: id,
            name: name,
            displayName: name.capitalizedFirstLetter(),
            artworkURL: URL(string: "https://sprites.test/official-artwork/\(id).png")
        )
    }

    static func pokedex(entries: [(id: Int, name: String)]) -> Pokedex {
        return Pokedex(
            id: 1,
            name: "national",
            isMainSeries: true,
            description: "National Pokedex",
            entries: entries.map { pokedexEntry(id: $0.id, name: $0.name) }
        )
    }

    static func pokemon(id: Int = 6,
                        name: String = "charizard",
                        types: [PokemonType] = [.Fire, .Flying],
                        stats: [PokemonStat] = [PokemonStat(kind: .hp, baseValue: 78)],
                        heightInMeters: Float = 1.7,
                        weightInKilograms: Float = 90.5) -> Pokemon {
        return Pokemon(
            id: id,
            name: name,
            displayName: name.capitalizedFirstLetter(),
            order: 7,
            baseExperience: 267,
            heightInMeters: heightInMeters,
            weightInKilograms: weightInKilograms,
            types: types,
            stats: stats,
            artworkURL: URL(string: "https://sprites.test/official-artwork/\(id).png")
        )
    }

    static func species(englishText: String = "Spits fire.") -> PokemonSpecies {
        return PokemonSpecies(flavorTexts: [
            FlavorText(text: "Crache du feu.", languageCode: "fr", versionName: "red"),
            FlavorText(text: englishText, languageCode: "en", versionName: "red")
        ])
    }

    static func typeFilter(_ type: PokemonType, ids: Set<Int>) -> PokemonTypeFilter {
        return PokemonTypeFilter(type: type, nationalPokedexIDs: ids)
    }

    static func regions() -> PokedexRegion {
        return PokedexRegion(entries: [
            PokedexRegionEntry(id: 1, name: "national", displayName: "National")
        ])
    }
}
