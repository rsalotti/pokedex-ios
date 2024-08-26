
# Pokedex iOS - WatchOS & SwiftUI Study Project

Welcome to the Pokedex iOS project! This repository serves as a study project aimed at exploring the WatchOS environment and the SwiftUI framework. As someone new to these technologies, this project is designed to help understand and apply the latest best practices in WatchOS development using SwiftUI.

## Overview

This project is a Pokedex application built for WatchOS using SwiftUI. It provides a simple interface to browse and search for Pokémon, displaying their details and statistics in a user-friendly format.

## Project Goals

- **Learn SwiftUI**: Gain a solid understanding of the SwiftUI framework, including its declarative syntax and how it differs from UIKit.
- **Explore WatchOS Development**: Understand the unique aspects of developing for WatchOS, such as interface constraints, performance considerations, and user interaction patterns.
- **Apply Modern Best Practices**: Implement the latest development practices in WatchOS and SwiftUI, including data binding, state management, and efficient UI updates.

## Features

- **Pokémon List**: Browse a list of Pokémon with their names and images.
- **Pokémon Details**: View detailed information about each Pokémon, including type, abilities, and stats.
- **WatchOS Compatibility**: Designed specifically for WatchOS with a focus on performance and usability on smaller screens.

## Installation

To run the project locally:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/rsalotti/pokedex-ios.git
   ```
2. **Open the project in Xcode**:
   ```bash
   cd pokedex-ios
   open Pokedex.xcodeproj
   ```
3. **Select the WatchOS target** in Xcode.
4. **Run the project** on a WatchOS simulator or device.

## Technology Stack

- **Swift**: Programming language used for developing the app.
- **SwiftUI**: Framework used for building the user interface.
- **WatchOS**: Target platform for the application.

## Best Practices

This project follows several modern best practices in WatchOS and SwiftUI development:

- **State Management**: Utilizes `@State`, `@Binding`, and `@ObservedObject` to manage the state of the application efficiently.
- **Modular Design**: The codebase is organized into small, reusable components, making it easy to maintain and extend.
- **Performance Optimization**: Focus on minimizing UI updates and using lightweight components to ensure smooth performance on WatchOS.

## Lessons Learned

Through the development of this project, the following key concepts were reinforced:

- **SwiftUI's Declarative Syntax**: Understanding how to think in a declarative manner, which is different from the imperative style of UIKit.
- **WatchOS UI Constraints**: Learning how to design interfaces that are both functional and visually appealing on the small screen of an Apple Watch.
- **Efficient State Management**: Recognizing the importance of managing state correctly to avoid unnecessary re-renders and improve app performance.

## Contributing

Contributions are welcome! If you have suggestions for improvements or new features, feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

For questions or feedback, feel free to reach out via [GitHub Issues](https://github.com/rsalotti/pokedex-ios/issues).
