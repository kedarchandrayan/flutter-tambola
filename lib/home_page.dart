import 'package:flutter/material.dart';
import 'dart:math';
import 'constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> calledNumbers = [];
  int currentNumber = 0;
  bool _gameStarted = false; // Flag to track whether the game has started

  void _nextNumber() {
    setState(() {
      if (!_gameStarted) {
        // Set _gameStarted to true when the first number is generated
        _gameStarted = true;
      }

      currentNumber = _generateRandomNumber();
      if (currentNumber == -1) {
        // Game has ended, show a message or perform any other desired action
        _showGameEndedDialog();
      } else {
        calledNumbers.add(currentNumber);
      }
    });
  }

  void _showGameEndedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content:
              const Text('All numbers have been called. The game has ended.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _restartGame(); // Restart the game
              },
              child: const Text('Restart Game'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _restartGame() {
    setState(() {
      calledNumbers.clear();
      currentNumber = 0;
      _gameStarted = false;
    });
  }

  void _showRestartConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Restart Game'),
          content: const Text('Are you sure you want to restart the game?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _restartGame(); // Restart the game
              },
              child: const Text('Restart'),
            ),
          ],
        );
      },
    );
  }

  int _generateRandomNumber() {
    List<int> availableNumbers = List<int>.generate(90, (index) => index + 1)
        .where((number) => !calledNumbers.contains(number))
        .toList();

    if (availableNumbers.isEmpty) {
      // Handle the case where all numbers are already called
      return -1;
    }

    return availableNumbers[Random().nextInt(availableNumbers.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambola'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Display the current number in big font
          Text(
            _gameStarted
                ? (currentNumber <= 0 ? 'Game Over' : '$currentNumber')
                : 'Welcome!',
            style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          // Number board
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
            ),
            itemCount: 90,
            itemBuilder: (context, index) {
              int number = index + 1;
              bool isCalled = calledNumbers.contains(number);
              return GestureDetector(
                onTap: () {
                  // Handle tap on each number if needed
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isCalled
                        ? kColorScheme.primary
                        : kColorScheme.onPrimary,
                    border: Border.all(color: kColorScheme.inversePrimary),
                  ),
                  child: Center(
                    child: Text(
                      '$number',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isCalled
                            ? kColorScheme.onPrimary
                            : kColorScheme.tertiary,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          // Button to get the next number
          ElevatedButton(
            onPressed: currentNumber >= 0 ? _nextNumber : null,
            child: _gameStarted
                ? const Text('Next Number')
                : const Text('Start Game'),
          ),
          const SizedBox(height: 20),
          // Button to restart the game
          ElevatedButton(
            onPressed: _gameStarted ? _showRestartConfirmationDialog : null,
            child: const Text('Restart Game'),
          ),
        ],
      ),
    );
  }
}
