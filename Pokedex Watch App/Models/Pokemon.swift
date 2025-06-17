//
//  Pokemon.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 28/08/24.
//

import Foundation

struct Pokemon: Codable {
    ///Height está em Decimetro
    let height: Int
    let id: Int
    let baseExperience: Int
    let name: String
    let order: Int
    let stats: [Stat]
    let types: [TypeElement]
    let sprites: Sprites
    ///Weight está em Hectograma
    let weight: Int

    enum CodingKeys: String, CodingKey {
        case height
        case id
        case baseExperience = "base_experience"
        case name
        case order
        case stats
        case types
        case sprites
        case weight
    }
}

struct Stat: Codable {
    let baseStat: Int
    let effort: Int
    let stat: StatDetail

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

struct StatDetail: Codable {
    let name: String
    let url: String
}

struct TypeElement: Codable, Hashable {
    let slot: Int
    let type: TypeDetail
}

struct TypeDetail: Codable, Hashable {
    let name: PokemonType
    let url: String
}

struct Sprites: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
