//
//  PokemonDTO.swift
//  Pokedex Watch App
//
//  Created by Ricardo Salotti on 19/08/25.
//

import Foundation

///Resposta de `/pokemon/{id}/`.
struct PokemonDTO: Decodable {
    let id: Int
    let name: String
    let order: Int
    let baseExperience: Int
    ///Vem em decímetros.
    let height: Int
    ///Vem em hectogramas.
    let weight: Int
    let stats: [PokemonStatDTO]
    let types: [PokemonTypeSlotDTO]
    let sprites: PokemonSpritesDTO

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case order
        case baseExperience = "base_experience"
        case height
        case weight
        case stats
        case types
        case sprites
    }
}

struct PokemonStatDTO: Decodable {
    let baseStat: Int
    let effort: Int
    let stat: NamedResourceDTO

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}

struct PokemonTypeSlotDTO: Decodable {
    let slot: Int
    let type: NamedResourceDTO
}

struct PokemonSpritesDTO: Decodable {
    ///A PokéAPI devolve `null` para alguns Pokémon sem sprite.
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
