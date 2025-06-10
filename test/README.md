# Testing Structure

## Unit Tests
Unit tests are located in the `test/` directory and follow the same structure as the `lib/` directory:

```
test/
├── core/
│   ├── error/
│   ├── network/
│   └── utils/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── pages/
    ├── providers/
    └── widgets/
```

## Widget Tests
Widget tests are located alongside the unit tests in the `test/` directory, specifically in the `presentation/` folder.

## Integration Tests
Integration tests are located in the `integration_test/` directory:

```
integration_test/
├── app_test.dart
└── features/
    ├── auth/
    ├── ideas/
    └── profile/
```

## Running Tests

### Unit and Widget Tests
```bash
flutter test
```

### Integration Tests
```bash
flutter test integration_test
```

### Coverage Report
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## Test Naming Convention
- Unit tests: `[name]_test.dart`
- Widget tests: `[widget_name]_test.dart`
- Integration tests: `[feature_name]_test.dart`

## Test Structure
Each test file should follow this structure:
```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Feature/Component Name', () {
    setUp(() {
      // Setup code
    });

    test('should do something', () {
      // Test code
    });

    testWidgets('should render correctly', (WidgetTester tester) async {
      // Widget test code
    });
  });
}
``` 