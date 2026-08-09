<p align="center">
  <img src="https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png" width="140" alt="Pikachu"/>
</p>

<h1 align="center">⌚ Pokedex watchOS</h1>

<p align="center">
  <strong>A native watchOS Pokédex built with SwiftUI, exploring Apple Watch hardware integration and modern Swift architecture.</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-watchOS-blue?logo=apple" alt="Platform: watchOS"/>
  <img src="https://img.shields.io/badge/Swift-5.9+-F05138?logo=swift&logoColor=white" alt="Swift 5.9+"/>
  <img src="https://img.shields.io/badge/SwiftUI-4.0+-007AFF?logo=swift&logoColor=white" alt="SwiftUI"/>
  <img src="https://img.shields.io/badge/Architecture-MVVM-green" alt="Architecture: MVVM"/>
  <img src="https://img.shields.io/badge/API-PokéAPI-EF5350" alt="API: PokéAPI"/>
  <img src="https://img.shields.io/badge/License-MIT-yellow" alt="License: MIT"/>
</p>

---

## 📸 Screenshots

![Pokedex watchOS Screenshots](https://github.com/user-attachments/assets/409ca4bf-43e8-4a79-a96b-5ae350c9b977)

---

## 📖 About

This project is a **study-driven** Pokédex application built exclusively for **Apple Watch**. It was created to explore the unique challenges and opportunities of watchOS development — from designing interfaces for small screens to integrating hardware controls like the **Digital Crown** with haptic feedback.

The app consumes the [PokéAPI](https://pokeapi.co/) REST API to display a complete National Pokédex with detailed information for each Pokémon.

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| 🏠 **National Pokédex** | Browse 1,025+ Pokémon with sprite thumbnails and names |
| 📊 **Detailed Stats** | View HP, Attack, Defense, Sp. Atk, Sp. Def, and Speed with animated progress bars |
| 📝 **Pokémon Descriptions** | Read official flavor text entries for each species |
| 🎨 **Type System** | Visual representation of all 18 Pokémon types with dedicated icons and colors |
| 🔘 **Digital Crown Selector** | Radial type filter using trigonometric layout controlled by the Apple Watch's Digital Crown |
| 📳 **Haptic Feedback** | Native haptic responses when navigating through types |
| 💀 **Skeleton Loading** | Blinking placeholder cells while content is being fetched |
| ⚡ **Parallel Requests** | Concurrent API calls using Swift's `async let` for faster data loading |

---

## 🏗️ Architecture

The project follows the **MVVM (Model-View-ViewModel)** pattern with a **Repository** layer for data access:

```
┌─────────────────────────────────────────────────────┐
│                       Views                         │
│  PokemonHomeView · PokemonDetailView · TypeView     │
├─────────────────────────────────────────────────────┤
│                    ViewModels                       │
│  PokemonHomeViewModel · PokemonDetailViewModel      │
│  (@MainActor + @ObservableObject)                   │
├─────────────────────────────────────────────────────┤
│                    Repository                       │
│  PokeRepository (PokeRepositoryProtocol)            │
├─────────────────────────────────────────────────────┤
│                     Network                         │
│  Network<T> + PokeAPI (Moya TargetType)             │
├─────────────────────────────────────────────────────┤
│                     Models                          │
│  Pokemon · Pokedex · PokemonSpecies · PokemonType   │
└─────────────────────────────────────────────────────┘
```

### Key Design Decisions

- **Repository Pattern** — `PokeRepositoryProtocol` abstracts the networking layer, enabling easy mocking for tests and decoupling ViewModels from implementation details.
- **Generic Network Wrapper** — `Network<T: TargetType>` bridges Moya's callback-based API into Swift's `async/await` using `withCheckedThrowingContinuation`.
- **Parallel Loading** — ViewModels use `async let` to fire concurrent requests and `await` their combined results:

```swift
Task {
    async let detail: () = fetchPokemonDetail()
    async let species: () = fetchPokemonSpecies()
    _ = await (detail, species)
}
```

---

## 📂 Project Structure

```
Pokedex Watch App/
│
├── 📁 Supporting Files/
│   └── PokedexApp.swift                  # @main entry point
│
├── 📁 Models/
│   ├── Pokedex.swift                     # National Pokédex & entry models
│   ├── PokedexRegion.swift               # Pokédex region listing
│   ├── Pokemon.swift                     # Full Pokémon entity (stats, types, sprites)
│   ├── PokemonSpecies.swift              # Species flavor text entries
│   └── PokemonType.swift                 # 18 types enum with images & colors
│
├── 📁 Services/Network/
│   ├── Network.swift                     # Generic Moya → async/await wrapper
│   ├── PokeAPI.swift                     # Moya TargetType (5 endpoints)
│   └── PokeRepository.swift              # Repository protocol + implementation
│
├── 📁 Views/
│   ├── 📁 Components/
│   │   ├── ProgressBarView.swift         # Animated horizontal stat bar
│   │   └── SkeletonCellView.swift        # Loading placeholder with blink effect
│   └── 📁 Screens/
│       ├── PokemonHome/                  # List screen (NavigationStack + List)
│       ├── PokemonDetail/                # Detail screen (TabView with 3 pages)
│       └── PokemonType/                  # Radial type selector (Digital Crown)
│
├── 📁 Utilities/
│   ├── Extensions/String+Extension.swift # capitalizedFirstLetter()
│   └── Modifiers/BlinkViewModifier.swift # Pulsing opacity animation modifier
│
└── 📁 Resources/
    ├── Assets.xcassets                   # App icon, type icons, type colors
    ├── en.lproj/Localizable.strings      # Localized strings
    └── Generated/                        # SwiftGen auto-generated constants
        ├── Assets.swift                  # Asset namespace (images & colors)
        └── Strings.swift                 # L10n namespace (localization)
```

---

## 🛠️ Tech Stack

| Technology | Purpose |
|-----------|---------|
| **Swift 5.9+** | Programming language |
| **SwiftUI** | Declarative UI framework |
| **Swift Concurrency** | `async/await`, `async let` for parallel execution |
| **[Moya](https://github.com/Moya/Moya)** | Type-safe network abstraction layer |
| **[Kingfisher](https://github.com/onevcat/Kingfisher)** | Async image loading & caching |
| **[SwiftGen](https://github.com/SwiftGen/SwiftGen)** | Code generation for type-safe assets & strings |
| **Swift Package Manager** | Dependency management |

---

## 🔌 API Endpoints

All data is fetched from [PokéAPI v2](https://pokeapi.co/api/v2):

| Endpoint | Route | Description |
|----------|-------|-------------|
| `getRegions` | `/region/` | List all Pokémon regions |
| `getAllPokedexRegions` | `/pokedex/` | List all Pokédex entries by region |
| `getPokemons(region)` | `/pokedex/{id}/` | Get Pokémon list for a specific region |
| `getPokemon(id)` | `/pokemon/{id}/` | Get full Pokémon details |
| `getPokemonSpecies(id)` | `/pokemon-species/{id}/` | Get species info & flavor text |

---

## 📱 Screens

### 1. Home — Pokémon List
The main screen displays a scrollable list of all Pokémon from the National Pokédex. Each row shows a sprite thumbnail loaded via **Kingfisher** and the Pokémon's name. A toolbar button opens the type filter overlay.

### 2. Detail — Pokémon Info (3 Tabs)
A paged `TabView` with three swipeable sections:

| Tab | Content |
|-----|---------|
| **Overview** | Type icons, official sprite, height (m), weight (kg), base experience |
| **Stats** | 6 animated `ProgressBarView` bars colored by the Pokémon's primary type |
| **Description** | English flavor text from the species endpoint |

### 3. Type Selector — Radial Wheel
A custom circular layout displaying all 18 Pokémon type icons arranged using trigonometric calculations (`cos`/`sin`). The user navigates between types using:
- **Digital Crown** rotation with haptic snapping
- **Tap** on any individual type icon

---

## 🎓 Lessons Learned

- **SwiftUI's Declarative Paradigm** — Thinking in terms of state-driven UI rather than imperative view updates.
- **watchOS UI Constraints** — Designing functional and visually appealing interfaces for the Apple Watch's small screen.
- **State Management** — Correctly using `@State`, `@Binding`, `@StateObject`, and `@ObservedObject` to avoid unnecessary re-renders.
- **Digital Crown Integration** — Leveraging `.digitalCrownRotation()` with sensitivity control, continuous mode, and haptic feedback.
- **Swift Concurrency** — Bridging callback-based APIs (Moya) into modern `async/await` and running parallel requests with `async let`.
- **Code Generation** — Using SwiftGen to eliminate hardcoded strings and asset references, achieving compile-time safety.

---

## 🚀 Getting Started

### Prerequisites

- **Xcode 15.0+**
- **watchOS 10.0+** SDK
- macOS Sonoma or later (recommended)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/rsalotti/pokedex-ios.git
   ```

2. **Open the project:**
   ```bash
   cd pokedex-ios
   open Pokedex.xcodeproj
   ```

3. **Select the target:**
   Choose `Pokedex Watch App` in the Xcode scheme selector.

4. **Run:**
   Build and run on a watchOS Simulator or a paired Apple Watch.

> **Note:** Dependencies are managed via Swift Package Manager and will be resolved automatically when you open the project.

---

## 🤝 Contributing

Contributions are welcome! Feel free to:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

## 📬 Contact

**Ricardo Salotti** — [GitHub](https://github.com/rsalotti) · [Issues](https://github.com/rsalotti/pokedex-ios/issues)

---

<p align="center">
  <sub>Built with ❤️ and ☕ for Apple Watch</sub>
</p>
