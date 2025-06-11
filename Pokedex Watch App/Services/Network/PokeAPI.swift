//
//  PokeAPI.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 26/08/24.
//

import SwiftUI
import Moya

enum PokeAPI {
    case getRegions
    case getPokemons(region: Int)
    case getPokemon(id: Int)
    case getPokemonSpecies(id: Int)
}

extension PokeAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://pokeapi.co/api/v2") ?? URL(fileURLWithPath: "")
    }
    
    var path: String {
        switch self {
        case .getRegions:
            return "/region/"
        case .getPokemons(let region):
            return "/pokedex/\(region)/"
        case .getPokemon(let id):
            return "/pokemon/\(id)/"
        case .getPokemonSpecies(let id):
            return "/pokemon-species/\(id)/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case    .getRegions,
                .getPokemons(_),
                .getPokemon(_),
                .getPokemonSpecies(_):
            return .get
        }
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
