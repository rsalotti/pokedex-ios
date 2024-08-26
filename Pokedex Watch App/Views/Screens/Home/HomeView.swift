//
//  ContentView.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 13/08/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: DetailView()) {
                    PokeListView(id: "001", name: "Bulbasaur")
                }
            }
        }
    }
}
