//
//  PokemonMapperTests.swift
//  Pokedex Watch AppTests
//
//  Created by Ricardo Salotti on 19/08/25.
//

import XCTest
@testable import Pokedex_Watch_App

final class PokemonMapperTests: XCTestCase {
    private let decoder = JSONDecoder()

    private func map(_ json: String) throws -> Pokemon {
        let dto = try decoder.decode(PokemonDTO.self, from: Fixtures.data(json))
        return PokemonMapper.map(dto)
    }

    // MARK: - Unidades

    ///A API entrega decímetro e hectograma. A UI nunca deveria ver esses números crus.
    func testConverteAlturaDeDecimetroParaMetro() throws {
        let pokemon = try map(Fixtures.charizard)
        XCTAssertEqual(pokemon.heightInMeters, 1.7, accuracy: 0.001)
    }

    func testConvertePesoDeHectogramaParaQuilo() throws {
        let pokemon = try map(Fixtures.charizard)
        XCTAssertEqual(pokemon.weightInKilograms, 90.5, accuracy: 0.001)
    }

    // MARK: - Tipos

    ///O JSON traz o slot 2 primeiro de propósito: o tipo primário é o do slot 1.
    func testOrdenaTiposPeloSlot() throws {
        let pokemon = try map(Fixtures.charizard)
        XCTAssertEqual(pokemon.types, [.Fire, .Flying])
        XCTAssertEqual(pokemon.primaryType, .Fire)
    }

    ///Um tipo novo na API não pode derrubar a decodificação do Pokémon inteiro.
    func testDescartaTipoDesconhecidoSemQuebrar() throws {
        let pokemon = try map(Fixtures.pokemonWithNullSpritesAndUnknownEntries)
        XCTAssertTrue(pokemon.types.isEmpty)
        XCTAssertNil(pokemon.primaryType)
    }

    // MARK: - Stats

    ///O JSON vem embaralhado; a View itera direto, então a ordem sai do mapper.
    func testOrdenaStatsNaOrdemCanonica() throws {
        let pokemon = try map(Fixtures.charizard)
        XCTAssertEqual(pokemon.stats.map(\.kind),
                       [.hp, .attack, .defense, .specialAttack, .specialDefense, .speed])
        XCTAssertEqual(pokemon.stats.map(\.baseValue), [78, 84, 78, 109, 85, 100])
    }

    func testDescartaStatDesconhecido() throws {
        let pokemon = try map(Fixtures.pokemonWithNullSpritesAndUnknownEntries)
        XCTAssertEqual(pokemon.stats.map(\.kind), [.hp])
    }

    func testStatExpoeTituloLocalizado() throws {
        let pokemon = try map(Fixtures.charizard)
        let hp = try XCTUnwrap(pokemon.stats.first)
        XCTAssertEqual(hp.title, L10n.Pokemon.hp)
        XCTAssertEqual(hp.id, .hp)
    }

    // MARK: - Artwork

    func testPrefereArteOficialQuandoAAPIDevolve() throws {
        let pokemon = try map(Fixtures.charizard)
        XCTAssertEqual(pokemon.artworkURL?.absoluteString,
                       "https://sprites.test/official-artwork/6.png")
    }

    ///Sem o bloco `other`, a URL tem que sair do mesmo template que a lista usa,
    ///senão as duas telas mostram imagens diferentes.
    func testCaiNoTemplateQuandoNaoHaArteOficial() throws {
        let pokemon = try map(Fixtures.pokemonWithoutArtwork)
        XCTAssertEqual(pokemon.artworkURL, PokeAPIRules.artworkURL(forNationalID: 25))
    }

    func testCaiNoTemplateQuandoArteOficialEhNula() throws {
        let pokemon = try map(Fixtures.pokemonWithNullSpritesAndUnknownEntries)
        XCTAssertEqual(pokemon.artworkURL, PokeAPIRules.artworkURL(forNationalID: 999))
    }

    ///`front_default` nulo derrubava a decodificação antes de o campo virar opcional.
    func testDecodificaSpritesNulosSemLancarErro() {
        XCTAssertNoThrow(try map(Fixtures.pokemonWithNullSpritesAndUnknownEntries))
    }

    // MARK: - Nome

    func testCapitalizaNomeParaExibicao() throws {
        let pokemon = try map(Fixtures.charizard)
        XCTAssertEqual(pokemon.name, "charizard")
        XCTAssertEqual(pokemon.displayName, "Charizard")
    }
}
