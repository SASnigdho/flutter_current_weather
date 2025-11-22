# Flutter Current Weather App

A simple Flutter application that displays the current weather information based on the user's location.

## Screenshot

![App Screenshot](assets/images/Screenshot_20251122_233752.jpg)

## Folder Structure

The project follows a standard Flutter project structure, with the main application code located in the `lib` directory. The folder structure is organized as follows:

```
├── android
├── build
├── ios
├── lib
│   ├── src
│   │   ├── app.dart
│   │   ├── core
│   │   ├── data
│   │   ├── domain
│   │   └── presentation
│   └── main.dart
├── linux
├── macos
├── web
└── windows
```

- **`lib/`**: Contains the main Dart code for the application.
  - **`main.dart`**: The entry point of the application.
  - **`app.dart`**: The root widget of the application.
  - **`core/`**: Contains the core components of the application, such as constants, error handling, network utilities, and widgets.
  - **`data/`**: Contains the data layer of the application, including data sources, models, and repositories.
  - **`domain/`**: Contains the domain layer of the application, including entities, repositories, and use cases.
  - **`presentation/`**: Contains the presentation layer of the application, including pages, widgets, controllers and bindings.

## Getting Started

### Prerequisites

- Flutter SDK: `^3.10.1`
- Java Development Kit (JDK): Version 17 is recommended.

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/your-username/flutter_current_weather.git
   ```
2. Navigate to the project directory:
   ```sh
   cd flutter_current_weather
   ```
3. Install the dependencies:
   ```sh
   flutter pub get
   ```
4. Run the application:
   ```sh
   flutter run
   ```