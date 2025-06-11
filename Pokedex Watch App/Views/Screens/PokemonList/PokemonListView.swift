//
//  PokemonListView.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 13/08/24.
//

import SwiftUI
import Kingfisher

struct PokemonListView: View {
    @StateObject var viewModel = PokemonListViewModel()
    @State var isLoading: Bool = true
    
    var body: some View {
        NavigationView {
            ZStack {
                List(viewModel.getPokemons()) { pokemon in
                    let destination = PokemonDetailView(viewModel: PokemonDetailViewModel(idPokemon: pokemon.id))
                    NavigationLink(destination: destination) {
                        PKMRowView(pokemon)
                    }
                }
                .navigationTitle(viewModel.regionTitle)
            }
        }
    }
    
    @ViewBuilder
    func PKMRowView(_ pokemon: PKDPokemonEntry) -> some View {
        HStack {
            KFImage(URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemon.id).png"))
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
    PokemonListView(viewModel: PokemonListViewModel(),
                    isLoading: true)
}
