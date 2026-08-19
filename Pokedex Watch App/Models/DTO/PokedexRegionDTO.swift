//
//  PokedexRegionDTO.swift
//  Pokedex Watch App
//
//  Created by Ricardo Salotti on 19/08/25.
//

import Foundation

///Resposta de `/pokedex/` — a lista de todas as Pokédex, uma por região.
struct PokedexRegionDTO: Decodable {
    let results: [NamedResourceDTO]
}
