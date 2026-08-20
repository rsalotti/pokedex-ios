//
//  PokemonDetailViewModelTests.swift
//  Pokedex Watch AppTests
//
//  Created by Ricardo Salotti on 19/08/25.
//

import XCTest
@testable import Pokedex_Watch_App

@MainActor
final class PokemonDetailViewModelTests: XCTestCase {
    private var repository: MockPokeRepository!
    private var viewModel: PokemonDetailViewModel!

    override func setUp() {
        super.setUp()
        repository = MockPokeRepository()
        repository.pokemonResult = .success(ModelBuilder.pokemon())
        repository.speciesResult = .success(ModelBuilder.species())
        viewModel = PokemonDetailViewModel(idPokemon: 6, repository: repository)
    }

    override func tearDown() {
        viewModel = nil
        repository = nil
        super.tearDown()
    }

    // MARK: - Carregamento

    func testComecaCarregandoSemDados() {
        XCTAssertEqual(viewModel.state, .loading)
        XCTAssertNil(viewModel.pokemon)
        XCTAssertNil(viewModel.pokemonSpecies)
    }

    func testCarregaDetalheEEspecieDoIdPedido() async {
        await viewModel.loadIfNeeded()

        XCTAssertEqual(viewModel.state, .loaded)
        XCTAssertEqual(viewModel.pokemon?.id, 6)
        XCTAssertNotNil(viewModel.pokemonSpecies)
        XCTAssertEqual(repository.requestedPokemonIDs, [6])
        XCTAssertEqual(repository.speciesCallCount, 1)
    }

    func testNaoRefazAsChamadasQuandoJaTemOsDados() async {
        await viewModel.loadIfNeeded()
        await viewModel.loadIfNeeded()

        XCTAssertEqual(repository.pokemonCallCount, 1)
        XCTAssertEqual(repository.speciesCallCount, 1)
    }

    // MARK: - Erro e retry

    ///Antes o erro virava `print` e a tela ficava presa no `ProgressView`.
    func testVaiParaEstadoDeErroQuandoODetalheFalha() async {
        repository.pokemonResult = .failure(MockPokeRepository.StubError.semRede)

        await viewModel.loadIfNeeded()

        XCTAssertEqual(viewModel.state, .failed)
        XCTAssertNil(viewModel.pokemon)
    }

    ///Detalhe e espécie vão juntos: sem a descrição a aba fica quebrada.
    func testVaiParaEstadoDeErroQuandoAEspecieFalha() async {
        repository.speciesResult = .failure(MockPokeRepository.StubError.semRede)

        await viewModel.loadIfNeeded()

        XCTAssertEqual(viewModel.state, .failed)
    }

    func testRetryRecarregaDepoisDoErro() async {
        repository.pokemonResult = .failure(MockPokeRepository.StubError.semRede)
        await viewModel.loadIfNeeded()
        XCTAssertEqual(viewModel.state, .failed)

        repository.pokemonResult = .success(ModelBuilder.pokemon())
        await viewModel.retry()

        XCTAssertEqual(viewModel.state, .loaded)
        XCTAssertEqual(viewModel.pokemon?.displayName, "Charizard")
    }

    // MARK: - Dados derivados

    func testTituloUsaOTextoDeCarregandoAteChegarOPokemon() async {
        XCTAssertEqual(viewModel.navigationTitle, L10n.Common.loading)

        await viewModel.loadIfNeeded()

        XCTAssertEqual(viewModel.navigationTitle, "Charizard")
    }

    func testDescricaoUsaOTextoEmIngles() async {
        repository.speciesResult = .success(ModelBuilder.species(englishText: "Spits fire."))

        await viewModel.loadIfNeeded()

        XCTAssertEqual(viewModel.description, "Spits fire.")
    }

    func testDescricaoEhNulaAntesDeCarregar() {
        XCTAssertNil(viewModel.description)
    }

    ///A cor das barras vem do tipo primário (slot 1).
    func testCorDaBarraVemDoTipoPrimario() async {
        repository.pokemonResult = .success(ModelBuilder.pokemon(types: [.Water, .Flying]))

        await viewModel.loadIfNeeded()

        XCTAssertEqual(viewModel.barColor, PokemonType.Water.color)
    }

    func testCorDaBarraTemPadraoQuandoNaoHaTipo() async {
        repository.pokemonResult = .success(ModelBuilder.pokemon(types: []))

        await viewModel.loadIfNeeded()

        XCTAssertEqual(viewModel.barColor, PokemonType.Bug.color)
    }

    func testExpoeOsStatsNaOrdemDoModel() async {
        let stats = [
            PokemonStat(kind: .hp, baseValue: 78),
            PokemonStat(kind: .speed, baseValue: 100)
        ]
        repository.pokemonResult = .success(ModelBuilder.pokemon(stats: stats))

        await viewModel.loadIfNeeded()

        XCTAssertEqual(viewModel.stats.map(\.kind), [.hp, .speed])
        XCTAssertEqual(viewModel.stats.map(\.baseValue), [78, 100])
    }

    func testStatsFicamVaziosAntesDeCarregar() {
        XCTAssertTrue(viewModel.stats.isEmpty)
    }

    // MARK: - Formatação

    func testFormataAlturaEPesoJaConvertidos() async {
        await viewModel.loadIfNeeded()

        XCTAssertEqual(viewModel.getHeightDescription(), L10n.Format.height(1.7))
        XCTAssertEqual(viewModel.getWeightDescription(), L10n.Format.weight(90.5))
    }

    func testFormatacaoDevolveVazioAntesDeCarregar() {
        XCTAssertEqual(viewModel.getHeightDescription(), "")
        XCTAssertEqual(viewModel.getWeightDescription(), "")
    }
}
