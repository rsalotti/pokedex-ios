//
//  PokemonDetailView.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 26/08/24.
//

import SwiftUI

struct PokemonDetailView: View {
    @StateObject var viewModel: PokemonDetailViewModel
    
    var body: some View {
        TabView {
            ScrollView {
                VStack {
                    Image.getPokemonKantoImage(for: viewModel.pokemon?.id ?? 1)
                        .resizable()
                        .frame(width: 85, height: 85, alignment: .center)
                    Text(viewModel.pokemon?.name.capitalizedFirstLetter() ?? "Unknown")
                        .font(.title2)
                        .bold()
                    if let pokemon = viewModel.pokemon {
                        generateTypeViews(pokemon)
                    }
                }
            }
            
            Text("Lorem ipsum")
        }
    }
    
    func generateTypeViews(_ pokemon: Pokemon) -> some View {
        HStack(spacing: -10) {
            ForEach(pokemon.types, id: \.self) { element in
                element.type.name.image
                    .resizable()
                    .frame(width: 50, height: 50)
            }
        }
    }
}
