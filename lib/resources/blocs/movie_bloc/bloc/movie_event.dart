import 'package:equatable/equatable.dart';
import 'package:movie_db/resources/model/movie_model.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class GetMovieList extends MovieEvent {
  final int page;
  const GetMovieList(this.page);
}

class SelectMovieEvent extends MovieEvent {
  final Movie movie;
  const SelectMovieEvent(this.movie);
}
