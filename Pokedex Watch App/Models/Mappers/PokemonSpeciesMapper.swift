//
//  PokemonSpeciesMapper.swift
//  Pokedex Watch App
//
//  Created by Ricardo Salotti on 19/08/25.
//

import Foundation

enum PokemonSpeciesMapper: DTOMapper {
    static func map(_ dto: PokemonSpeciesDTO) -> PokemonSpecies {
        return PokemonSpecies(
            flavorTexts: dto.flavorTextEntries.map { flavorText(from: $0) }
        )
    }

    private static func flavorText(from dto: FlavorTextEntryDTO) -> FlavorText {
        return FlavorText(
            text: sanitize(dto.flavorText),
            languageCode: dto.language.name,
            versionName: dto.version.name
        )
    }

    ///Os textos originais vêm com quebras de linha fixas, form feed (`\u{0C}`) e soft hyphen,
    ///herdados da caixa de texto dos jogos. Sem limpar, a descrição quebra em lugares
    ///aleatórios na tela do Watch.
    private static func sanitize(_ text: String) -> String {
        let separators = CharacterSet.whitespacesAndNewlines
            .union(CharacterSet(charactersIn: "\u{0C}\u{00AD}"))

        return text
            .components(separatedBy: separators)
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }
}
