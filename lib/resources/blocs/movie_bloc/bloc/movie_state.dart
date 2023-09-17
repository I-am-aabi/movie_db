import 'package:equatable/equatable.dart';
import 'package:movie_db/resources/model/movie_model.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object?> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final MovieModel movieModel;
  const MovieLoaded(this.movieModel);
}

class SelectedMovieState extends MovieState {
  final Movie movie;
  const SelectedMovieState(this.movie);
}

class MovieError extends MovieState {
  final String? message;
  const MovieError(this.message);
}
class SelectedMovieError extends MovieState{
  final String? message;
  const SelectedMovieError(this.message);
}