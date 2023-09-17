import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_db/resources/blocs/movie_bloc/bloc/movie_event.dart';
import 'package:movie_db/resources/blocs/movie_bloc/bloc/movie_state.dart';

import 'package:movie_db/resources/services/api_repository.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {
    final ApiRepository apiRepository = ApiRepository();

    on<GetMovieList>((event, emit) async {
      try {
        emit(MovieLoading());
        final mList = await apiRepository.fetchMovieList(event.page);
        emit(MovieLoaded(mList));
        if (mList.error != null) {
          emit(MovieError(mList.error));
        }
      } on NetworkError {
        emit(const MovieError("Failed to fetch data. is your device online?"));
      }
    });
    on<SelectMovieEvent>((event, emit) {
      emit(SelectedMovieState(event.movie));
    });
    // on<SelectMovieEvent>(selectedMovieEvent);
  }

  FutureOr<void> selectedMovieEvent(
      SelectMovieEvent event, Emitter<MovieState> emit) {
    emit(SelectedMovieState(event.movie));
    print(event.movie.title);
  }
}
