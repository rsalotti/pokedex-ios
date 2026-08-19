//
//  DTOMapper.swift
//  Pokedex Watch App
//
//  Created by Ricardo Salotti on 19/08/25.
//

import Foundation

///Contrato de tradução entre o que a API devolve (DTO) e o que a UI consome (Model final).
///Mappers não fazem I/O e não guardam estado: só transformam.
protocol DTOMapper {
    associatedtype DTO: Decodable
    associatedtype Model

    static func map(_ dto: DTO) -> Model
}

extension DTOMapper {
    static func map(_ dtos: [DTO]) -> [Model] {
        return dtos.map { map($0) }
    }
}

///Conversões de unidade e limites compartilhados pelos mappers.
enum PokeAPIRules {
    ///Formas alternativas (Mega, Gigantamax, regionais) vêm com id acima disso
    ///e não têm entrada na Pokédex Nacional.
    static let lastNationalEntryID: Int = 10000

    ///A API entrega altura em decímetros e peso em hectogramas.
    static let decimetersToMeters: Float = 10
    static let hectogramsToKilograms: Float = 10

    ///Monta a URL do sprite a partir do número nacional.
    static func spriteURL(forNationalID id: Int) -> URL? {
        let path = L10n.Sprite.url.replacingOccurrences(of: L10n.Common.element, with: String(id))
        return URL(string: path)
    }
}
