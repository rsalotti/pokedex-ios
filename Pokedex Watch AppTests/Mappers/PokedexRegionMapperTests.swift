//
//  PokedexRegionMapperTests.swift
//  Pokedex Watch AppTests
//
//  Created by Ricardo Salotti on 19/08/25.
//

import XCTest
@testable import Pokedex_Watch_App

final class PokedexRegionMapperTests: XCTestCase {
    private func mapRegions() throws -> PokedexRegion {
        let dto = try JSONDecoder().decode(PokedexRegionDTO.self, from: Fixtures.data(Fixtures.pokedexRegions))
        return PokedexRegionMapper.map(dto)
    }

    func testExtraiOIdDaUrlDoRecurso() throws {
        let regioes = try mapRegions()
        XCTAssertEqual(regioes.entries.map(\.id), [1, 3])
    }

    ///URL sem id descarta só aquela entrada, o resto da lista continua válido.
    func testDescartaEntradaComUrlSemId() throws {
        let regioes = try mapRegions()
        XCTAssertEqual(regioes.entries.count, 2)
        XCTAssertFalse(regioes.entries.contains { $0.name == "quebrado" })
    }

    func testCapitalizaONomeParaExibicao() throws {
        let regioes = try mapRegions()
        XCTAssertEqual(regioes.entries.map(\.displayName), ["National", "Original-johto"])
    }
}
