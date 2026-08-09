//
//  PokemonHomeView.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 13/08/24.
//

import SwiftUI
import Kingfisher

struct PokemonHomeView: View {
    @StateObject var viewModel = PokemonHomeViewModel()
    @State var showFilter: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(viewModel.getPokemons()) { pokemon in
                    let destination = PokemonDetailView(viewModel: PokemonDetailViewModel(idPokemon: pokemon.id))
                    NavigationLink(destination: destination) {
                        PKMRowView(pokemon)
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button(action: {
                            showFilter.toggle()
                        }) {
                            Image(systemName: "list.bullet")
                        }
                    }
                }
                .fullScreenCover(isPresented: $showFilter) {
                    
                } content: {
                    PokemonTypeView()
                }


            }
        }
    }
    
    @ViewBuilder
    func PKMRowView(_ pokemon: PKDPokemonEntry) -> some View {
        HStack {
            let url = L10n.Sprite.url.replacingOccurrences(of: L10n.Common.element, with: String(pokemon.id))
            KFImage(URL(string: url))
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
                .padding(.trailing, 8)
            Text(pokemon.pokemonSpecies.name.capitalizedFirstLetter())
                .font(.title3)
                .lineLimit(1)
        }
    }
}

#Preview {
    PokemonHomeView(viewModel: PokemonHomeViewModel())
}
