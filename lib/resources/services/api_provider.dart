import 'package:dio/dio.dart';
import 'package:movie_db/resources/model/movie_model.dart';

class ApiProvider {
  final Dio _dio = Dio();
  static String key = '8d404a107a7382750cb19074575ba76c';
  

  Future<MovieModel> fetchMoviesList(int page) async {
     final String url =
      'https://api.themoviedb.org/3/trending/movie/day?language=en-US&api_key=$key&page=$page';
    try {
      Response response = await _dio.get(url);
      return MovieModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieModel.withError("Data not found / Connection issue");
    }
  }
}
