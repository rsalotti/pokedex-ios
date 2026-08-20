//
//  StringExtensionTests.swift
//  Pokedex Watch AppTests
//
//  Created by Ricardo Salotti on 19/08/25.
//

import XCTest
@testable import Pokedex_Watch_App

final class StringExtensionTests: XCTestCase {
    // MARK: - capitalizedFirstLetter

    func testCapitalizaAPrimeiraLetra() {
        XCTAssertEqual("pikachu".capitalizedFirstLetter(), "Pikachu")
    }

    ///Diferente de `.capitalized`, o resto da string não pode ser mexido:
    ///"charizard-mega-x" viraria "Charizard-Mega-X".
    func testNaoAlteraORestanteDaString() {
        XCTAssertEqual("charizard-mega-x".capitalizedFirstLetter(), "Charizard-mega-x")
        XCTAssertEqual("POKeMON".capitalizedFirstLetter(), "POKeMON")
    }

    func testSuportaStringVaziaEUmCaractere() {
        XCTAssertEqual("".capitalizedFirstLetter(), "")
        XCTAssertEqual("a".capitalizedFirstLetter(), "A")
    }

    func testSuportaAcentoENaoLetra() {
        XCTAssertEqual("écureuil".capitalizedFirstLetter(), "Écureuil")
        XCTAssertEqual("2-mega".capitalizedFirstLetter(), "2-mega")
    }

    // MARK: - pokeAPIResourceID

    func testExtraiOIdDeUmaUrlComBarraFinal() {
        XCTAssertEqual("https://pokeapi.co/api/v2/pokemon/25/".pokeAPIResourceID, 25)
    }

    func testExtraiOIdDeUmaUrlSemBarraFinal() {
        XCTAssertEqual("https://pokeapi.co/api/v2/pokemon/1025".pokeAPIResourceID, 1025)
    }

    func testDevolveNilQuandoNaoHaIdNoFim() {
        XCTAssertNil("https://pokeapi.co/api/v2/pokemon/".pokeAPIResourceID)
        XCTAssertNil("".pokeAPIResourceID)
        XCTAssertNil("nao-e-uma-url".pokeAPIResourceID)
    }
}
