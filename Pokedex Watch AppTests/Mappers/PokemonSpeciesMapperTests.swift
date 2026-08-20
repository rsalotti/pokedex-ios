//
//  PokemonSpeciesMapperTests.swift
//  Pokedex Watch AppTests
//
//  Created by Ricardo Salotti on 19/08/25.
//

import XCTest
@testable import Pokedex_Watch_App

final class PokemonSpeciesMapperTests: XCTestCase {
    private let decoder = JSONDecoder()

    private func map(_ json: String) throws -> PokemonSpecies {
        let dto = try decoder.decode(PokemonSpeciesDTO.self, from: Fixtures.data(json))
        return PokemonSpeciesMapper.map(dto)
    }

    // MARK: - Limpeza do texto

    ///Regressão: a primeira versão usava `\u{0C}` no padrão, sintaxe de string do Swift
    ///que o regex ICU não aceita. O padrão inválido falhava e o texto passava intacto.
    func testRemoveQuebrasDeLinhaEFormFeedDoTextoOriginal() throws {
        let species = try map(Fixtures.charizardSpecies)
        let texto = try XCTUnwrap(species.flavorText(languageCode: "en"))

        XCTAssertFalse(texto.contains("\n"), "quebra de linha dos jogos vazou para a UI")
        XCTAssertFalse(texto.contains("\u{0C}"), "form feed dos jogos vazou para a UI")
    }

    func testColapsaEspacosRepetidos() throws {
        let species = try map(Fixtures.charizardSpecies)
        let texto = try XCTUnwrap(species.flavorText(languageCode: "en"))
        XCTAssertFalse(texto.contains("  "))
    }

    func testTextoLimpoMantemAsPalavrasNaOrdem() throws {
        let species = try map(Fixtures.charizardSpecies)
        XCTAssertEqual(species.flavorText(languageCode: "en"),
                       "Spits fire that is hot enough to melt boulders. Known to cause forest fires.")
    }

    // MARK: - Idioma

    func testEscolheOTextoDoIdiomaPedido() throws {
        let species = try map(Fixtures.charizardSpecies)
        XCTAssertEqual(species.flavorText(languageCode: "fr"), "Il crache un feu si chaud.")
    }

    ///Quando o mesmo idioma aparece em várias versões do jogo, vale a primeira.
    func testUsaAPrimeiraEntradaQuandoOIdiomaSeRepete() throws {
        let species = try map(Fixtures.charizardSpecies)
        let texto = try XCTUnwrap(species.flavorText(languageCode: "en"))
        XCTAssertTrue(texto.hasPrefix("Spits fire"))
    }

    func testDevolveNilParaIdiomaAusente() throws {
        let species = try map(Fixtures.charizardSpecies)
        XCTAssertNil(species.flavorText(languageCode: "ja"))
    }

    func testPreservaOIdiomaEAVersaoDeCadaEntrada() throws {
        let species = try map(Fixtures.charizardSpecies)
        XCTAssertEqual(species.flavorTexts.count, 3)
        XCTAssertEqual(species.flavorTexts.map(\.languageCode), ["fr", "en", "en"])
        XCTAssertEqual(species.flavorTexts.map(\.versionName), ["red", "red", "blue"])
    }
}
