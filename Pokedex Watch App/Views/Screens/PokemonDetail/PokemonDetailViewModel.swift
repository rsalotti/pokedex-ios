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
    @Published var pokemonSpecies: PokemonSpecies?
    
    private var statValues: [String: CGFloat] {
        guard let pokemon else { return [:] }
        return Dictionary(uniqueKeysWithValues:
            pokemon.stats.map { ($0.stat.name, CGFloat($0.baseStat)) }
        )
    }

    var statHPValue: CGFloat { statValues[L10n.Key.hp] ?? 0 }
    var statAttackValue: CGFloat { statValues[L10n.Key.attack] ?? 0 }
    var statDefenseValue: CGFloat { statValues[L10n.Key.defense] ?? 0 }
    var statSAttackValue: CGFloat { statValues[L10n.Key.specialAttack] ?? 0}
    var statSDefenseValue: CGFloat { statValues[L10n.Key.specialDefense] ?? 0}
    var statSpeedValue: CGFloat { statValues[L10n.Key.speed] ?? 0}

    var barColor: Color {
        guard let barColor = pokemon?.types.first?.type.name.color else { return .bug }
        return barColor
    }
    
    init(idPokemon: Int) {
        self.idPokemon = idPokemon
        self.pokemon = nil
        self.pokemonSpecies = nil
        
        //Tarefa Async logo após iniciar todas as variáveis.
        Task {
            await fetchPokemonDetail()
            await fetchPokemonSpecies()
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
    
    func fetchPokemonSpecies() async {
        do {
            let specie = try await PokeRepository().fetchSinglePokemonSpecies(id: idPokemon)
            DispatchQueue.main.async {
                self.pokemonSpecies = specie
            }
        } catch let error {
            // FIXME: - Corrigir caso dê algum problema
            print(error.localizedDescription)
        }
    }
    
    func getWeightDescription() -> String {
        guard let pokemon = pokemon else { return "" }
        let weightInKilos = Float(pokemon.weight) / 10.0
        return L10n.Format.weight(weightInKilos)
    }
    
    func getHeightDescription() -> String {
        guard let pokemon = pokemon else { return "" }
        let heightInMeters = Float(pokemon.height) / 10.0
        return L10n.Format.height(heightInMeters)
    }
}

