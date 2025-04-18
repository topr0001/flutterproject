import 'package:flutter/foundation.dart';
import '../data/httphelper.dart';
import '../data/movie.dart';

class MovieProvider extends ChangeNotifier {
  static List<RentedMovie> searchResults = [];

  static Future<List<RentedMovie>> searchMovies(String keyword) async {
    return await HttpHelper.searchMovies(keyword);
  }
}
