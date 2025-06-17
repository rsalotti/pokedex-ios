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
    @State var isLoading: Bool = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(viewModel.getPokemons()) { pokemon in
                    let destination = PokemonDetailView(viewModel: PokemonDetailViewModel(idPokemon: pokemon.id))
                    NavigationLink(destination: destination) {
                        PKMRowView(pokemon)
                    }
                }
                .navigationTitle(viewModel.regionTitle)
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button(action: {
                            print("Tipos tapped")
                        }) {
                            Image(systemName: "list.bullet")
                        }
                    }
                }
            }
        }    }
    
    @ViewBuilder
    func PKMRowView(_ pokemon: PKDPokemonEntry) -> some View {
        HStack {
            KFImage(URL(string: L10n.Sprite.url(pokemon.id)))
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
    PokemonHomeView(viewModel: PokemonHomeViewModel(),
                    isLoading: true)
}
