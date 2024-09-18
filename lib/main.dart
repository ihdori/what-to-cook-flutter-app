import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:what2cooke/screens/home_page.dart';
import 'package:what2cooke/screens/result_screen.dart';

void main() async {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'شطبخ؟',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'ibm',
      ),
      routes: {
        // '/': (context) => HomePage(),
        'result': (context) => ResultScreen(),
      },
      home: const HomePage(),
    );
  }
}
