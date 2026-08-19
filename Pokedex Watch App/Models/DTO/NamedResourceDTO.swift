//
//  NamedResourceDTO.swift
//  Pokedex Watch App
//
//  Created by Ricardo Salotti on 19/08/25.
//

import Foundation

///A PokéAPI representa quase toda referência a outro recurso com o par `name` + `url`
///(idiomas, espécies, stats, versões, tipos...). Um único DTO cobre todos esses casos.
struct NamedResourceDTO: Decodable {
    let name: String
    let url: String
}
