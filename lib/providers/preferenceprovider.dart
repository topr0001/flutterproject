import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/movie.dart';

class PreferenceProvider extends ChangeNotifier {
  final String _rentedKey = 'rentedMovies';
  List<RentedMovie> _rentedMovies = [];

  List<RentedMovie> get rentedMovies => _rentedMovies;

  Future<void> init() async {
    await getRentedMovies();
  }

  Future<void> addRentedMovie(RentedMovie movie) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> stored = prefs.getStringList(_rentedKey) ?? [];
    stored.add(json.encode(movie.toJson()));
    await prefs.setStringList(_rentedKey, stored);
    _rentedMovies.add(movie);
    notifyListeners();
  }

  Future<void> removeRentedMovie(RentedMovie movie) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> stored = prefs.getStringList(_rentedKey) ?? [];
    stored.removeWhere(
      (e) => RentedMovie.fromJson(json.decode(e)).id == movie.id,
    );
    await prefs.setStringList(_rentedKey, stored);
    _rentedMovies.removeWhere((e) => e.id == movie.id);
    notifyListeners();
  }

  Future<void> getRentedMovies() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> stored = prefs.getStringList(_rentedKey) ?? [];
    _rentedMovies =
        stored.map((e) => RentedMovie.fromJson(json.decode(e))).toList();
    notifyListeners();
  }
}
