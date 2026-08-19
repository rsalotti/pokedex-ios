//
//  PokemonHomeViewModel.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 27/08/24.
//

import Foundation
import SwiftUI

@MainActor
class PokemonHomeViewModel: ObservableObject {
    ///Estados possíveis da lista. A View decide o que desenhar a partir daqui.
    enum State: Equatable {
        case loading
        case loaded
        case failed
    }

    @Published private(set) var state: State = .loading
    @Published private(set) var pokedex: Pokedex?
    ///Tipo escolhido no seletor radial. `nil` significa "todos os tipos".
    @Published private(set) var selectedType: PokemonType?
    @Published private(set) var typeFilter: PokemonTypeFilter?

    private(set) var pokedexRegions: PokedexRegion?

    private let repository: PokeRepositoryProtocol
    ///All Pokemons in National Pokedex 1025 Entries
    private static let nationalPokedexID: Int = 1

    init(repository: PokeRepositoryProtocol = PokeRepository()) {
        self.repository = repository
    }

    /**
     All Public Methods
     */
    ///Pokémon exibidos na lista, já com o filtro de tipo aplicado quando houver.
    func getPokemons() -> [PokedexEntry] {
        guard let entries = pokedex?.entries else {
            return []
        }
        guard let typeFilter else {
            return entries
        }
        return entries.filter { typeFilter.contains($0) }
    }

    ///Chamado pela View no `.task`. Evita refazer o download da Pokédex a cada reaparição da tela.
    func loadIfNeeded() async {
        guard pokedex == nil else { return }
        await load()
    }

    ///Refaz o que estiver faltando (Pokédex e/ou filtro) depois de um erro.
    func retry() async {
        await load()
    }

    ///Aplica o filtro por tipo. Passar `nil` volta a listar todos os Pokémon.
    func selectType(_ type: PokemonType?) async {
        guard type != selectedType else { return }
        selectedType = type
        typeFilter = nil

        //Limpar o filtro não exige rede quando a Pokédex já está em mãos.
        if type == nil, pokedex != nil {
            state = .loaded
            return
        }
        await load()
    }

    /**
     All Private Methods
     */
    private func load() async {
        state = .loading
        //Regiões não bloqueiam a lista, então rodam em paralelo com o resto.
        async let regions: () = fetchPokedexRegions()

        do {
            if pokedex == nil {
                pokedex = try await repository.fetchRegionPokemons(id: Self.nationalPokedexID)
            }
            if let selectedType, typeFilter == nil {
                typeFilter = try await repository.fetchPokemonsOfType(name: selectedType.rawValue)
            }
            state = .loaded
        } catch {
            state = .failed
        }

        _ = await regions
    }

    private func fetchPokedexRegions() async {
        guard pokedexRegions == nil else { return }
        do {
            self.pokedexRegions = try await repository.fetchAllPokedexRegions()
        } catch let error {
            //Não afeta a lista principal, então só registra o erro.
            print(error.localizedDescription)
        }
    }
}
