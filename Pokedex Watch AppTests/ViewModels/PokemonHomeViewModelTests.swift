//
//  PokemonHomeViewModelTests.swift
//  Pokedex Watch AppTests
//
//  Created by Ricardo Salotti on 19/08/25.
//

import XCTest
@testable import Pokedex_Watch_App

@MainActor
final class PokemonHomeViewModelTests: XCTestCase {
    private var repository: MockPokeRepository!
    private var viewModel: PokemonHomeViewModel!

    override func setUp() {
        super.setUp()
        repository = MockPokeRepository()
        repository.pokedexResult = .success(
            ModelBuilder.pokedex(entries: [(1, "bulbasaur"), (4, "charmander"), (6, "charizard")])
        )
        repository.regionsResult = .success(ModelBuilder.regions())
        viewModel = PokemonHomeViewModel(repository: repository)
    }

    override func tearDown() {
        viewModel = nil
        repository = nil
        super.tearDown()
    }

    // MARK: - Carregamento

    func testComecaCarregandoComListaVazia() {
        XCTAssertEqual(viewModel.state, .loading)
        XCTAssertTrue(viewModel.getPokemons().isEmpty)
    }

    func testCarregaAPokedexNacional() async {
        await viewModel.loadIfNeeded()

        XCTAssertEqual(viewModel.state, .loaded)
        XCTAssertEqual(viewModel.getPokemons().map(\.id), [1, 4, 6])
        XCTAssertEqual(repository.pokedexCallCount, 1)
    }

    ///A tela pode reaparecer várias vezes; baixar 1025 entradas de novo seria caro no Watch.
    func testNaoRefazODownloadQuandoJaTemOsDados() async {
        await viewModel.loadIfNeeded()
        await viewModel.loadIfNeeded()

        XCTAssertEqual(repository.pokedexCallCount, 1)
    }

    ///As regiões são um extra: falhar nelas não pode derrubar a lista.
    func testListaCarregaMesmoComAsRegioesFalhando() async {
        repository.regionsResult = .failure(MockPokeRepository.StubError.semRede)

        await viewModel.loadIfNeeded()

        XCTAssertEqual(viewModel.state, .loaded)
        XCTAssertEqual(viewModel.getPokemons().count, 3)
    }

    // MARK: - Erro e retry

    ///Antes o erro só virava `print` e a tela ficava vazia para sempre.
    func testVaiParaEstadoDeErroQuandoAPokedexFalha() async {
        repository.pokedexResult = .failure(MockPokeRepository.StubError.semRede)

        await viewModel.loadIfNeeded()

        XCTAssertEqual(viewModel.state, .failed)
        XCTAssertTrue(viewModel.getPokemons().isEmpty)
    }

    func testRetryRecarregaDepoisDoErro() async {
        repository.pokedexResult = .failure(MockPokeRepository.StubError.semRede)
        await viewModel.loadIfNeeded()
        XCTAssertEqual(viewModel.state, .failed)

        repository.pokedexResult = .success(ModelBuilder.pokedex(entries: [(25, "pikachu")]))
        await viewModel.retry()

        XCTAssertEqual(viewModel.state, .loaded)
        XCTAssertEqual(viewModel.getPokemons().map(\.displayName), ["Pikachu"])
    }

    // MARK: - Filtro por tipo

    func testFiltraAListaPeloTipoEscolhido() async {
        await viewModel.loadIfNeeded()
        repository.typeFilterResult = .success(ModelBuilder.typeFilter(.Fire, ids: [4, 6]))

        await viewModel.selectType(.Fire)

        XCTAssertEqual(viewModel.state, .loaded)
        XCTAssertEqual(viewModel.selectedType, .Fire)
        XCTAssertEqual(viewModel.getPokemons().map(\.id), [4, 6])
        XCTAssertEqual(repository.requestedTypeNames, ["fire"])
    }

    func testFiltrarNaoRefazODownloadDaPokedex() async {
        await viewModel.loadIfNeeded()
        repository.typeFilterResult = .success(ModelBuilder.typeFilter(.Fire, ids: [6]))

        await viewModel.selectType(.Fire)

        XCTAssertEqual(repository.pokedexCallCount, 1)
    }

    func testLimparOFiltroDevolveAListaCompletaSemIrNaRede() async {
        await viewModel.loadIfNeeded()
        repository.typeFilterResult = .success(ModelBuilder.typeFilter(.Fire, ids: [6]))
        await viewModel.selectType(.Fire)

        await viewModel.selectType(nil)

        XCTAssertNil(viewModel.selectedType)
        XCTAssertEqual(viewModel.getPokemons().map(\.id), [1, 4, 6])
        XCTAssertEqual(repository.typeFilterCallCount, 1)
        XCTAssertEqual(repository.pokedexCallCount, 1)
    }

    ///Reabrir o seletor e confirmar o mesmo tipo não deveria custar uma requisição.
    func testEscolherODeMesmoTipoNovamenteNaoRefazARequisicao() async {
        await viewModel.loadIfNeeded()
        repository.typeFilterResult = .success(ModelBuilder.typeFilter(.Fire, ids: [6]))

        await viewModel.selectType(.Fire)
        await viewModel.selectType(.Fire)

        XCTAssertEqual(repository.typeFilterCallCount, 1)
    }

    func testVaiParaEstadoDeErroQuandoOFiltroFalha() async {
        await viewModel.loadIfNeeded()
        repository.typeFilterResult = .failure(MockPokeRepository.StubError.semRede)

        await viewModel.selectType(.Fire)

        XCTAssertEqual(viewModel.state, .failed)
    }

    func testRetryReaplicaOFiltroAtivo() async {
        await viewModel.loadIfNeeded()
        repository.typeFilterResult = .failure(MockPokeRepository.StubError.semRede)
        await viewModel.selectType(.Fire)
        XCTAssertEqual(viewModel.state, .failed)

        repository.typeFilterResult = .success(ModelBuilder.typeFilter(.Fire, ids: [4]))
        await viewModel.retry()

        XCTAssertEqual(viewModel.state, .loaded)
        XCTAssertEqual(viewModel.getPokemons().map(\.id), [4])
    }

    ///Regressão: limpar o filtro sem a Pokédex em mãos marcava a tela como carregada
    ///e mostrava "nenhum Pokémon" no lugar do erro.
    func testLimparOFiltroSemPokedexCarregadaTentaCarregarDeNovo() async {
        repository.pokedexResult = .failure(MockPokeRepository.StubError.semRede)
        await viewModel.loadIfNeeded()
        await viewModel.selectType(.Fire)
        XCTAssertEqual(viewModel.state, .failed)

        await viewModel.selectType(nil)

        XCTAssertEqual(viewModel.state, .failed)
        XCTAssertEqual(repository.pokedexCallCount, 3)
    }

    ///Escolher "todos os tipos" com o filtro já limpo não deveria fazer nada.
    func testSelecionarNilComFiltroJaLimpoNaoFazNada() async {
        await viewModel.loadIfNeeded()

        await viewModel.selectType(nil)

        XCTAssertEqual(repository.pokedexCallCount, 1)
        XCTAssertEqual(repository.typeFilterCallCount, 0)
    }
}
