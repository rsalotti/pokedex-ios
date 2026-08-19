//
//  Pokemon.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 28/08/24.
//

import Foundation

///Model final do Pokémon. As unidades da API (decímetro/hectograma) já chegam aqui convertidas.
struct Pokemon: Identifiable {
    let id: Int
    let name: String
    let displayName: String
    let order: Int
    let baseExperience: Int
    let heightInMeters: Float
    let weightInKilograms: Float
    let types: [PokemonType]
    ///Sempre na ordem canônica de `PokemonStatKind`.
    let stats: [PokemonStat]
    let spriteURL: URL?

    ///Tipo usado para colorir a UI do detalhe.
    var primaryType: PokemonType? {
        return types.first
    }
}

struct PokemonStat: Identifiable, Hashable {
    let kind: PokemonStatKind
    let baseValue: Int

    var id: PokemonStatKind { kind }
    var title: String { kind.title }
}

///Os `rawValue` são as chaves que a PokéAPI usa em `/pokemon/{id}/stats`.
enum PokemonStatKind: String, CaseIterable, Hashable {
    case hp
    case attack
    case defense
    case specialAttack = "special-attack"
    case specialDefense = "special-defense"
    case speed

    ///Maior valor base observado na série, usado como teto das barras de progresso.
    static let maxBaseValue: CGFloat = 255

    var title: String {
        switch self {
        case .hp: return L10n.Pokemon.hp
        case .attack: return L10n.Pokemon.attack
        case .defense: return L10n.Pokemon.defense
        case .specialAttack: return L10n.Pokemon.sattack
        case .specialDefense: return L10n.Pokemon.sdefense
        case .speed: return L10n.Pokemon.speed
        }
    }
}
