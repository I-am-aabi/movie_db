import 'package:flutter/material.dart';
import 'package:movie_db/resources/ui/home_screen.dart';
import 'package:movie_db/resources/ui/movie_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Movie app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: 'home',
      routes: {
        'home':(context) => const HomeScreen(),
        'movies':(context) =>  MovieScreen()
      },
      home:  const HomeScreen(),
    );
  }
}
