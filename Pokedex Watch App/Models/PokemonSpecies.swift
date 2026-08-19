//
//  PokemonSpecies.swift
//  Pokedex
//
//  Created by Ricardo Salotti on 10/06/25.
//

import Foundation

///Model final da espécie. Os textos já chegam limpos dos caracteres de controle da API.
struct PokemonSpecies {
    let flavorTexts: [FlavorText]

    ///Primeira descrição no idioma pedido. Ex: `"en"`.
    func flavorText(languageCode: String) -> String? {
        return flavorTexts.first { $0.languageCode == languageCode }?.text
    }
}

struct FlavorText: Hashable {
    let text: String
    let languageCode: String
    let versionName: String
}
