import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';


class HomePage  extends StatelessWidget {
    final String title;
    final int counter;
    // Constructor for HomePage
    const HomePage({super.key, required this.title, required this.counter});

    // Method to create a copy of HomePage with updated values
    HomePage copyWith({String? title, int? counter}) {
        return HomePage(
            title: title ?? this.title,
            counter: counter ?? this.counter,

        );
    }
    
      @override
      Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter: $counter'),
            ElevatedButton(
              onPressed: () {
                context.read<HomePageNotifier>().incrementCounter();
              },
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
      }
}

// StateNotifier to manage HomePage
class HomePageNotifier extends StateNotifier<HomePage> {
    HomePageNotifier()
            : super(HomePage(title: 'Home Page', counter: 0));

    void incrementCounter() {
        state = state.copyWith(counter: state.counter + 1);
    }

    void updateTitle(String newTitle) {
        state = state.copyWith(title: newTitle);
    }
}

// Provider for the HomePageNotifier
final homePageProvider =
        StateNotifierProvider<HomePageNotifier, HomePage>(
    (ref) => HomePageNotifier(),
);