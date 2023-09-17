
import 'package:movie_db/resources/services/api_provider.dart';
import 'package:movie_db/resources/model/movie_model.dart';


class ApiRepository {
  final _provider = ApiProvider();

  Future<MovieModel> fetchMovieList(int page) {
    return _provider.fetchMoviesList(page);
  }
}

class NetworkError extends Error {}