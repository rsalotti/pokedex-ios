//
//  Pokedex.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 26/08/24.
//

import Foundation

///Model final da Pokédex, já pronto para a UI. Quem monta é o `PokedexMapper`.
struct Pokedex {
    let id: Int
    let name: String
    let isMainSeries: Bool
    ///Descrição já resolvida para o idioma pedido no mapper.
    let description: String?
    let entries: [PokedexEntry]
}

///Uma linha da lista da Home.
struct PokedexEntry: Identifiable, Hashable {
    ///Número na Pokédex Nacional.
    let id: Int
    let name: String
    let displayName: String
    ///Mesma arte oficial usada no detalhe, para a lista e a tela cheia baterem.
    let artworkURL: URL?
}
