//
//  Pokemon.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 28/08/24.
//

import Foundation

struct Pokemon: Codable {
    let height: Int
    let id: Int
    let name: String
    let order: Int
    let stats: [Stat]
    let types: [TypeElement]
    let weight: Int

    enum CodingKeys: String, CodingKey {
        case height
        case id
        case name
        case order
        case stats
        case types
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

struct TypeElement: Codable {
    let slot: Int
    let type: TypeDetail
}

struct TypeDetail: Codable {
    let name: String
    let url: String
}
