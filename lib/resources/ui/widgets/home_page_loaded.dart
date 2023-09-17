import 'package:flutter/material.dart';
import 'package:movie_db/resources/blocs/movie_bloc/bloc/movie_bloc.dart';
import 'package:movie_db/resources/blocs/movie_bloc/bloc/movie_event.dart';
import 'package:movie_db/resources/model/movie_model.dart';

import 'package:movie_db/resources/ui/widgets/movie_card.dart';

Widget movieLoadedScreen(
    BuildContext context, MovieModel model, ScrollController controller) {
  final movies = model.results;
  MovieBloc movieBloc = MovieBloc();
  return SingleChildScrollView(
    controller: controller,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 150,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.titleLarge,
                  children: [
                    TextSpan(
                      text: 'Featured ',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                      text: 'Movies',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              for (final movie in movies)
                InkWell(
                  onTap: () {
                    movieBloc.add(SelectMovieEvent(movie));
                    Navigator.pushNamed(context, 'movies',arguments: movie);
                   
                  },
                  child: MovieListItem(
                    imageUrl: movie.posterPath,
                    name: movie.title,
                    information:
                        'Release Date:  ${movie.releaseDate}  | Rating ${movie.voteAverage!.toString().substring(0, 3)} ★',
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}
