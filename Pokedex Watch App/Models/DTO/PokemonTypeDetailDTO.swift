//
//  PokemonTypeDetailDTO.swift
//  Pokedex Watch App
//
//  Created by Ricardo Salotti on 19/08/25.
//

import Foundation

///Resposta de `/type/{name}/`. Usada para descobrir quais Pokémon têm um tipo.
struct PokemonTypeDetailDTO: Decodable {
    let name: String
    let pokemon: [PokemonTypeSlotEntryDTO]
}

struct PokemonTypeSlotEntryDTO: Decodable {
    let slot: Int
    let pokemon: NamedResourceDTO
}
