// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Common {
    /// Base Lv.
    internal static let baseLevel = L10n.tr("Localizable", "common.baseLevel", fallback: "Base Lv.")
    /// Height
    internal static let height = L10n.tr("Localizable", "common.height", fallback: "Height")
    /// Loading...
    internal static let loading = L10n.tr("Localizable", "common.loading", fallback: "Loading...")
    /// Weight
    internal static let weight = L10n.tr("Localizable", "common.weight", fallback: "Weight")
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
    /// attack
    internal static let attack = L10n.tr("Localizable", "key.attack", fallback: "attack")
    /// defense
    internal static let defense = L10n.tr("Localizable", "key.defense", fallback: "defense")
    /// en
    internal static let en = L10n.tr("Localizable", "key.en", fallback: "en")
    /// hp
    internal static let hp = L10n.tr("Localizable", "key.hp", fallback: "hp")
    /// special-attack
    internal static let specialAttack = L10n.tr("Localizable", "key.special-attack", fallback: "special-attack")
    /// special-defense
    internal static let specialDefense = L10n.tr("Localizable", "key.special-defense", fallback: "special-defense")
    /// speed
    internal static let speed = L10n.tr("Localizable", "key.speed", fallback: "speed")
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
    /// https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/%d.png
    internal static func url(_ p1: Int) -> String {
      return L10n.tr("Localizable", "sprite.url", p1, fallback: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/%d.png")
    }
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
