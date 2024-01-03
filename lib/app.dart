import 'package:flutter/material.dart';
import 'constants.dart';
import 'home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tambola',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: kColorScheme.onPrimaryContainer,
            onPrimary: kColorScheme.primaryContainer,
          ),
        ),
      ),
      home: const HomePage(),
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: const Text(
                  'Made in Bharat by Kedar Chandrayan',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
