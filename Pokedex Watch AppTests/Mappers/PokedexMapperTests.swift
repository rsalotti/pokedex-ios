//
//  PokedexMapperTests.swift
//  Pokedex Watch AppTests
//
//  Created by Ricardo Salotti on 19/08/25.
//

import XCTest
@testable import Pokedex_Watch_App

final class PokedexMapperTests: XCTestCase {
    private func mapNationalPokedex() throws -> Pokedex {
        let dto = try JSONDecoder().decode(PokedexDTO.self, from: Fixtures.data(Fixtures.nationalPokedex))
        return PokedexMapper.map(dto)
    }

    func testMapeiaOsDadosDaPokedex() throws {
        let pokedex = try mapNationalPokedex()
        XCTAssertEqual(pokedex.id, 1)
        XCTAssertEqual(pokedex.name, "national")
        XCTAssertTrue(pokedex.isMainSeries)
    }

    func testEscolheADescricaoEmIngles() throws {
        let pokedex = try mapNationalPokedex()
        XCTAssertEqual(pokedex.description, "National Pokedex")
    }

    ///O id da entrada é o número nacional (`entry_number`), não a posição na lista.
    func testUsaOEntryNumberComoIdentificador() throws {
        let pokedex = try mapNationalPokedex()
        XCTAssertEqual(pokedex.entries.map(\.id), [1, 4, 6])
    }

    func testCapitalizaONomeDaEspecie() throws {
        let pokedex = try mapNationalPokedex()
        XCTAssertEqual(pokedex.entries.map(\.name), ["bulbasaur", "charmander", "charizard"])
        XCTAssertEqual(pokedex.entries.map(\.displayName), ["Bulbasaur", "Charmander", "Charizard"])
    }

    ///A lista só tem o número, então monta a URL pelo template.
    func testMontaAUrlDaArtePeloNumeroNacional() throws {
        let pokedex = try mapNationalPokedex()
        let charizard = try XCTUnwrap(pokedex.entries.first { $0.id == 6 })
        XCTAssertEqual(charizard.artworkURL, PokeAPIRules.artworkURL(forNationalID: 6))
    }

    ///Lista e detalhe têm que resolver para a mesma imagem.
    func testUrlDaListaBateComADoDetalhe() throws {
        let pokedex = try mapNationalPokedex()
        let dto = try JSONDecoder().decode(PokemonDTO.self, from: Fixtures.data(Fixtures.pokemonWithoutArtwork))
        let pokemon = PokemonMapper.map(dto)

        let entrada = ModelBuilder.pokedexEntry(id: 25, name: "pikachu")
        XCTAssertEqual(pokemon.artworkURL, PokeAPIRules.artworkURL(forNationalID: entrada.id))
        XCTAssertFalse(pokedex.entries.isEmpty)
    }

    func testTemplateDaArteApontaParaOfficialArtwork() throws {
        let url = try XCTUnwrap(PokeAPIRules.artworkURL(forNationalID: 6))
        XCTAssertTrue(url.absoluteString.contains("official-artwork"))
        XCTAssertTrue(url.absoluteString.hasSuffix("/6.png"))
    }
}
