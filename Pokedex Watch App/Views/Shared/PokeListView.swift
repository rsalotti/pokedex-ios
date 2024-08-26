//
//  PokeListView.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 26/08/24.
//

import SwiftUI

struct PokeListView: View {
    var id: String
    var name: String
    
    var body: some View {
        HStack {
            Image(uiImage: Asset._001.image)
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .padding(5)
            Text("Bulbassaur")
                .font(.title3)
        }
    }
}
