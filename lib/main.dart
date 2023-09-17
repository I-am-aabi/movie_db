import 'package:flutter/material.dart';
import 'package:movie_db/resources/model/movie_model.dart';
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
          'home': (context) => const HomeScreen(),
          'movies': (context) {
            // Extract the arguments from the route
            final movie = ModalRoute.of(context)?.settings.arguments as Movie;

            // Pass the extracted movie to the MovieScreen widget
            return MovieScreen(movie: movie);
          },
        });
  }
}
