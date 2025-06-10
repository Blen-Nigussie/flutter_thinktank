# ThinkTank Flutter Project Architecture

## Project Structure
```
lib/
├── core/
│   ├── architecture/
│   │   ├── repositories/
│   │   └── usecases/
│   ├── error/
│   │   └── failures.dart
│   ├── network/
│   │   └── network_info.dart
│   └── utils/
│       └── constants.dart
├── data/
│   ├── datasources/
│   │   ├── local/
│   │   └── remote/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── presentation/
│   ├── pages/
│   ├── providers/
│   ├── widgets/
│   └── theme/
└── main.dart
```

## Architecture Layers

### 1. Presentation Layer
- Contains UI components (pages, widgets)
- Uses Riverpod for state management
- Handles user interactions
- Implements UI logic

### 2. Domain Layer
- Contains business logic
- Defines entities and use cases
- Independent of data sources
- Defines repository interfaces

### 3. Data Layer
- Implements repository interfaces
- Handles data sources (local and remote)
- Contains data models
- Manages data operations

### 4. Core Layer
- Contains shared utilities
- Defines common interfaces
- Handles error management
- Manages network operations

## Testing Structure
```
test/
├── core/
├── data/
├── domain/
├── presentation/
└── integration/
```

## Dependencies
- Riverpod for state management
- Dio for API calls
- Shared Preferences for local storage
- Flutter Test for unit and widget tests
- Integration Test for end-to-end testing 