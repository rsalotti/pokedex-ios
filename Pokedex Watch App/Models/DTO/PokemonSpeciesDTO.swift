//
//  PokemonSpeciesDTO.swift
//  Pokedex Watch App
//
//  Created by Ricardo Salotti on 19/08/25.
//

import Foundation

///Resposta de `/pokemon-species/{id}/`.
struct PokemonSpeciesDTO: Decodable {
    let flavorTextEntries: [FlavorTextEntryDTO]

    enum CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
    }
}

struct FlavorTextEntryDTO: Decodable {
    ///Texto cru, com quebras de linha e caracteres de controle da era dos cartuchos.
    let flavorText: String
    let language: NamedResourceDTO
    let version: NamedResourceDTO

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
        case version
    }
}
