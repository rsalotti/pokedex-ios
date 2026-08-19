//
//  PokemonDetailViewModel.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 28/08/24.
//

import SwiftUI

@MainActor
class PokemonDetailViewModel: ObservableObject {
    ///Estados possíveis da tela. A View decide o que desenhar a partir daqui.
    enum State: Equatable {
        case loading
        case loaded
        case failed
    }

    @Published private(set) var state: State = .loading
    @Published private(set) var pokemon: Pokemon?
    @Published private(set) var pokemonSpecies: PokemonSpecies?

    let idPokemon: Int
    private let repository: PokeRepositoryProtocol

    ///Stats já vêm do mapper na ordem canônica, então a View só precisa iterar.
    var stats: [PokemonStat] {
        return pokemon?.stats ?? []
    }

    ///Descrição da espécie no idioma do app.
    var description: String? {
        return pokemonSpecies?.flavorText(languageCode: L10n.Key.en)
    }

    var barColor: Color {
        return pokemon?.primaryType?.color ?? PokemonType.Bug.color
    }

    var navigationTitle: String {
        return pokemon?.displayName ?? L10n.Common.loading
    }

    init(idPokemon: Int, repository: PokeRepositoryProtocol = PokeRepository()) {
        self.idPokemon = idPokemon
        self.repository = repository
    }

    /**
     All Public Methods
     */
    ///Chamado pela View no `.task`. Não refaz as chamadas se os dados já estiverem em mãos.
    func loadIfNeeded() async {
        guard pokemon == nil else { return }
        await load()
    }

    func retry() async {
        await load()
    }

    func getWeightDescription() -> String {
        guard let pokemon else { return "" }
        return L10n.Format.weight(pokemon.weightInKilograms)
    }

    func getHeightDescription() -> String {
        guard let pokemon else { return "" }
        return L10n.Format.height(pokemon.heightInMeters)
    }

    /**
     All Private Methods
     */
    private func load() async {
        state = .loading
        //Detalhe e espécie são endpoints independentes, então vão em paralelo.
        async let detail = repository.fetchSinglePokemon(id: idPokemon)
        async let species = repository.fetchSinglePokemonSpecies(id: idPokemon)

        do {
            //O Await espera as 2 chamadas acima serem finalizadas.
            let (pokemon, pokemonSpecies) = try await (detail, species)
            self.pokemon = pokemon
            self.pokemonSpecies = pokemonSpecies
            state = .loaded
        } catch {
            state = .failed
        }
    }
}
