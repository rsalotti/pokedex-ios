//
//  PokemonDetailViewModel.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 28/08/24.
//

import SwiftUI

///Usando @MainActor no init para realizar a chamada assíncrona logo após a inicialização
/* Considerações importantes
    1.  Gerenciamento do Ciclo de Vida: Ao fazer uma chamada assíncrona no init, você deve garantir que a View não seja recriada ou destruída enquanto a tarefa assíncrona ainda está em andamento. Isso pode ocorrer, por exemplo, ao alternar entre diferentes telas.
    2.  Erros: Sempre trate erros adequadamente na função assíncrona para garantir que problemas de rede ou outras exceções não resultem em uma experiência ruim para o usuário.
    3.  Atualizações na UI: Certifique-se de que as atualizações no modelo ocorrem na thread principal, especialmente quando a interface do usuário depende dessas atualizações.
 Esse é um lembrete para mim.
 */
@MainActor
class PokemonDetailViewModel: ObservableObject {
    @Published var idPokemon: Int
    @Published var pokemon: Pokemon?
    
    init(idPokemon: Int) {
        self.idPokemon = idPokemon
        self.pokemon = nil
        
        //Tarefa Async logo após iniciar todas as variáveis.
        Task {
            await fetchPokemonDetail()
        }
    }
    
    func fetchPokemonDetail() async {
        do {
            let pokemon = try await PokeRepository().fetchSinglePokemon(id: idPokemon)
            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
        } catch let error {
            // FIXME: - Corrigir caso dê algum problema
            print(error.localizedDescription)
        }
    }
}
