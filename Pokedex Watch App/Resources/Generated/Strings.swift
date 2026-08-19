// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Common {
    /// All types
    internal static let allTypes = L10n.tr("Localizable", "common.allTypes", fallback: "All types")
    /// Base Lv.
    internal static let baseLevel = L10n.tr("Localizable", "common.baseLevel", fallback: "Base Lv.")
    /// $1
    internal static let element = L10n.tr("Localizable", "common.element", fallback: "$1")
    /// Height
    internal static let height = L10n.tr("Localizable", "common.height", fallback: "Height")
    /// Loading...
    internal static let loading = L10n.tr("Localizable", "common.loading", fallback: "Loading...")
    /// Retry
    internal static let retry = L10n.tr("Localizable", "common.retry", fallback: "Retry")
    /// Weight
    internal static let weight = L10n.tr("Localizable", "common.weight", fallback: "Weight")
  }
  internal enum Error {
    /// No Pokémon found for this type.
    internal static let emptyFilter = L10n.tr("Localizable", "error.emptyFilter", fallback: "No Pokémon found for this type.")
    /// Couldn't load the Pokédex.
    internal static let loadFailed = L10n.tr("Localizable", "error.loadFailed", fallback: "Couldn't load the Pokédex.")
  }
  internal enum Filter {
    /// Show all Pokémon
    internal static let clear = L10n.tr("Localizable", "filter.clear", fallback: "Show all Pokémon")
    /// Filter by type
    internal static let title = L10n.tr("Localizable", "filter.title", fallback: "Filter by type")
  }
  internal enum Format {
    /// %.1f m
    internal static func height(_ p1: Float) -> String {
      return L10n.tr("Localizable", "format.height", p1, fallback: "%.1f m")
    }
    /// %.1f kg
    internal static func weight(_ p1: Float) -> String {
      return L10n.tr("Localizable", "format.weight", p1, fallback: "%.1f kg")
    }
  }
  internal enum Key {
    /// Localizable.strings
    ///   Pokedex
    /// 
    ///   Created by Ricardo Salotti on 17/06/25.
    internal static let en = L10n.tr("Localizable", "key.en", fallback: "en")
  }
  internal enum Pokemon {
    /// Attack
    internal static let attack = L10n.tr("Localizable", "pokemon.attack", fallback: "Attack")
    /// Defense
    internal static let defense = L10n.tr("Localizable", "pokemon.defense", fallback: "Defense")
    /// HP
    internal static let hp = L10n.tr("Localizable", "pokemon.hp", fallback: "HP")
    /// S.Attack
    internal static let sattack = L10n.tr("Localizable", "pokemon.sattack", fallback: "S.Attack")
    /// S.Defense
    internal static let sdefense = L10n.tr("Localizable", "pokemon.sdefense", fallback: "S.Defense")
    /// Speed
    internal static let speed = L10n.tr("Localizable", "pokemon.speed", fallback: "Speed")
  }
  internal enum Sprite {
    /// https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$1.png
    internal static let artworkUrl = L10n.tr("Localizable", "sprite.artworkUrl", fallback: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$1.png")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
