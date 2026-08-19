//
//  PokemonMapper.swift
//  Pokedex Watch App
//
//  Created by Ricardo Salotti on 19/08/25.
//

import Foundation

enum PokemonMapper: DTOMapper {
    static func map(_ dto: PokemonDTO) -> Pokemon {
        return Pokemon(
            id: dto.id,
            name: dto.name,
            displayName: dto.name.capitalizedFirstLetter(),
            order: dto.order,
            baseExperience: dto.baseExperience,
            heightInMeters: Float(dto.height) / PokeAPIRules.decimetersToMeters,
            weightInKilograms: Float(dto.weight) / PokeAPIRules.hectogramsToKilograms,
            types: types(from: dto.types),
            stats: stats(from: dto.stats),
            artworkURL: artworkURL(from: dto)
        )
    }

    ///Prefere a arte oficial que a própria resposta traz. Quando o campo vem vazio,
    ///monta a URL pelo número nacional — a mesma regra da lista, para as duas telas baterem.
    private static func artworkURL(from dto: PokemonDTO) -> URL? {
        if let path = dto.sprites.other?.officialArtwork?.frontDefault {
            return URL(string: path)
        }
        return PokeAPIRules.artworkURL(forNationalID: dto.id)
    }

    ///Respeita o `slot` da API (slot 1 é o tipo primário) e ignora tipos que o app não conhece.
    private static func types(from dtos: [PokemonTypeSlotDTO]) -> [PokemonType] {
        return dtos
            .sorted { $0.slot < $1.slot }
            .compactMap { PokemonType(rawValue: $0.type.name) }
    }

    ///Devolve sempre na ordem canônica de `PokemonStatKind`, independente da ordem da API.
    private static func stats(from dtos: [PokemonStatDTO]) -> [PokemonStat] {
        let valuesByKind = Dictionary(
            dtos.compactMap { dto -> (PokemonStatKind, Int)? in
                guard let kind = PokemonStatKind(rawValue: dto.stat.name) else { return nil }
                return (kind, dto.baseStat)
            },
            uniquingKeysWith: { first, _ in first }
        )

        return PokemonStatKind.allCases.compactMap { kind in
            guard let value = valuesByKind[kind] else { return nil }
            return PokemonStat(kind: kind, baseValue: value)
        }
    }
}
