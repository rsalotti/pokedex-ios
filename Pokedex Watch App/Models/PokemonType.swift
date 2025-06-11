//
//  PokemonType.swift
//  Pokedex Watch App
//
//  Created by Ricardo Santos on 30/08/24.
//

import SwiftUI

enum PokemonType: String, Codable, Hashable {
    case Bug = "bug"
    case Dark = "dark"
    case Dragon = "dragon"
    case Electric = "electric"
    case Fairy = "fairy"
    case Fight = "fighting"
    case Fire = "fire"
    case Flying = "flying"
    case Ghost = "ghost"
    case Grass = "grass"
    case Ground = "ground"
    case Ice = "ice"
    case Normal = "normal"
    case Poison = "poison"
    case Psychic = "psychic"
    case Rock = "rock"
    case Steel = "steel"
    case Water = "water"
    
    var image: Image {
        switch self {
        case .Bug: return Asset.bug.swiftUIImage
        case .Dark: return Asset.dark.swiftUIImage
        case .Dragon: return Asset.dragon.swiftUIImage
        case .Electric: return Asset.electric.swiftUIImage
        case .Fairy: return Asset.fairy.swiftUIImage
        case .Fight: return Asset.fight.swiftUIImage
        case .Fire: return Asset.fire.swiftUIImage
        case .Flying: return Asset.flying.swiftUIImage
        case .Ghost: return Asset.ghost.swiftUIImage
        case .Grass: return Asset.grass.swiftUIImage
        case .Ground: return Asset.ground.swiftUIImage
        case .Ice: return Asset.ice.swiftUIImage
        case .Normal: return Asset.normal.swiftUIImage
        case .Poison: return Asset.poison.swiftUIImage
        case .Psychic: return Asset.psychic.swiftUIImage
        case .Rock: return Asset.rock.swiftUIImage
        case .Steel: return Asset.steel.swiftUIImage
        case .Water: return Asset.water.swiftUIImage
        }
    }
    
    var color: Color {
        switch self {
        case .Bug: return Asset.bugColor.swiftUIColor
        case .Dark: return Asset.darkColor.swiftUIColor
        case .Dragon: return Asset.dragonColor.swiftUIColor
        case .Electric: return Asset.electricColor.swiftUIColor
        case .Fairy: return Asset.fairyColor.swiftUIColor
        case .Fight: return Asset.fightColor.swiftUIColor
        case .Fire: return Asset.fireColor.swiftUIColor
        case .Flying: return Asset.flyingColor.swiftUIColor
        case .Ghost: return Asset.ghostColor.swiftUIColor
        case .Grass: return Asset.grassColor.swiftUIColor
        case .Ground: return Asset.groundColor.swiftUIColor
        case .Ice: return Asset.iceColor.swiftUIColor
        case .Normal: return Asset.normalColor.swiftUIColor
        case .Poison: return Asset.poisonColor.swiftUIColor
        case .Psychic: return Asset.psychicColor.swiftUIColor
        case .Rock: return Asset.rockColor.swiftUIColor
        case .Steel: return Asset.steelColor.swiftUIColor
        case .Water: return Asset.waterColor.swiftUIColor
        }
    }
}
