import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/movie.dart';

class HttpHelper {
  static Future<List<RentedMovie>> searchMovies(String keyword) async {
    String apiKey = '7a474e64344e9ed334bc40aa52ba9e52';
    String url =
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$keyword';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['results'];
      return (data as List).map((json) => RentedMovie.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}
