import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:what2cocke/screens/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:what2cocke/screens/result_screen.dart';
import 'package:what2cocke/screens/test_temp.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    anonKey: dotenv.env['APIKEY'].toString(),
    url: dotenv.env['URL'].toString(),
  );

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
