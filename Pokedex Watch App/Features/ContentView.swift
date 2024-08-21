//
//  ContentView.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 13/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Image("001")
                        .resizable()
                        .frame(width: 45, height: 45, alignment: .center)
                        .padding(5)
                    Text("Bulbassaur")
                        .font(.title3)
                }
                
                HStack {
                    Image("002")
                        .resizable()
                        .frame(width: 45, height: 45, alignment: .center)
                        .padding(5)
                    Text("Ivysaur")
                        .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                    
                }
                
                HStack {
                    Image("003")
                        .resizable()
                        .frame(width: 45, height: 45, alignment: .center)
                        .padding(5)
                    Text("Venossaur")
                        .font(.title3)
                }
                
                HStack {
                    Image(systemName: "globe")
                    Text("Hello")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
