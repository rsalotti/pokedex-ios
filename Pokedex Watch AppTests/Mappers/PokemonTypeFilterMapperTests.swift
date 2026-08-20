//
//  PokemonTypeFilterMapperTests.swift
//  Pokedex Watch AppTests
//
//  Created by Ricardo Salotti on 19/08/25.
//

import XCTest
@testable import Pokedex_Watch_App

final class PokemonTypeFilterMapperTests: XCTestCase {
    private func map(_ json: String) throws -> PokemonTypeFilter {
        let dto = try JSONDecoder().decode(PokemonTypeDetailDTO.self, from: Fixtures.data(json))
        return PokemonTypeFilterMapper.map(dto)
    }

    ///O id do Pokémon só existe dentro da URL do recurso.
    func testExtraiOsIdsDaUrlDoRecurso() throws {
        let filtro = try map(Fixtures.fireType)
        XCTAssertTrue(filtro.nationalPokedexIDs.contains(4))
        XCTAssertTrue(filtro.nationalPokedexIDs.contains(6))
    }

    ///Megas e formas regionais têm id acima de 10000 e não existem na Pokédex Nacional,
    ///então filtrar por elas deixaria a lista com buracos.
    func testDescartaFormasAlternativasForaDaPokedexNacional() throws {
        let filtro = try map(Fixtures.fireType)
        XCTAssertFalse(filtro.nationalPokedexIDs.contains(10034))
        XCTAssertEqual(filtro.nationalPokedexIDs.count, 2)
    }

    func testResolveOTipoPeloNome() throws {
        let filtro = try map(Fixtures.fireType)
        XCTAssertEqual(filtro.type, .Fire)
    }

    ///Um tipo que o app ainda não mapeou não pode virar um tipo errado.
    func testDevolveTipoNiloQuandoOAppNaoConheceONome() throws {
        let filtro = try map(Fixtures.unknownType)
        XCTAssertNil(filtro.type)
        XCTAssertEqual(filtro.nationalPokedexIDs, [1024])
    }

    func testContainsAceitaSomenteEntradasDoTipo() throws {
        let filtro = try map(Fixtures.fireType)
        XCTAssertTrue(filtro.contains(ModelBuilder.pokedexEntry(id: 6, name: "charizard")))
        XCTAssertFalse(filtro.contains(ModelBuilder.pokedexEntry(id: 1, name: "bulbasaur")))
    }
}
