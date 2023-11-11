import 'dart:convert';

import 'package:briix/movie.dart';
import 'package:briix/test_movies.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart' as mx;
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  late SharedPreferences prefs;
  final mx.Observable<bool> isReady = mx.Observable(false);
  static const String _moviesKey = 'movies', _genresKey = 'genres';
  static const List<String> genres = [
    'Action',
    'Adventure',
    'Animation',
    'Biography',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Fantasy',
    'Film Noir',
    'History',
    'Horror',
    'Music',
    'Musical',
    'Mystery',
    'Romance',
    'Sci-Fi',
    'Short Film',
    'Sport',
    'Superhero',
    'Thriller',
    'War',
    'Western',
  ];

  static Future<void> init() async {
    if (GetIt.I.isRegistered<SharedPref>()) {
      final SharedPref sp = GetIt.I.get<SharedPref>();
      await sp.prefs.reload();
      sp.isReady.value = true;
      return;
    }
    final SharedPref sp1 = SharedPref();
    GetIt.I.registerSingleton<SharedPref>(sp1);
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp1.prefs = sp;

    final List<String>? genresList = sp.getStringList(_genresKey);
    if (genresList == null) sp.setStringList(_genresKey, genres);
    final String? moviesJson = sp.getString(_moviesKey);
    if (moviesJson == null) {
      sp.setString(
          _moviesKey, json.encode(testMovies.map((e) => e.toJson()).toList()));
    }
    sp1.isReady.value = true;
  }

  List<Movie> getLocalMovies() {
    final String? moviesJson = prefs.getString(_moviesKey);
    if (moviesJson == null) throw Exception('No movies found');
    final List<dynamic> moviesList = json.decode(moviesJson);
    return moviesList.map<Movie>((e) => Movie.fromJson(e)).toList();
  }

  void saveLocalMovies(List<Movie> movies) {
    final List<Map<String, dynamic>> moviesList =
        movies.map((e) => e.toJson()).toList();
    final String moviesJson = json.encode(moviesList);
    prefs.setString(_moviesKey, moviesJson);
  }

  List<String> getLocalGenres() {
    final List<String>? genresList = prefs.getStringList(_genresKey);
    if (genresList == null) return genres;
    return genresList;
  }

  void saveLocalGenres(List<String> genres) {
    prefs.setStringList(_genresKey, genres);
  }
}
