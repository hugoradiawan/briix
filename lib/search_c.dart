import 'package:briix/movie.dart';
import 'package:briix/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart' as mx;

class SearchC {
  final TextEditingController tec = TextEditingController();
  final SharedPref sp = GetIt.I.get<SharedPref>();
  final mx.ObservableList<Movie> movies = mx.ObservableList<Movie>(),
      filteredMovies = mx.ObservableList<Movie>();

  SearchC() {
    tec.addListener(() => mx.Action(() => _onTextChanged(tec.text))());
    sp.isReady.observe((p0) {
      if (p0.newValue ?? false) return;
      getLocalMovies();
    });
  }

  void _onTextChanged(String text) {
    filteredMovies.clear();
    if (text.isEmpty) {
      filteredMovies.addAll(movies);
    } else {
      filteredMovies.addAll(movies
          .where((e) => e.title.toLowerCase().contains(text.toLowerCase()))
          .toList());
    }
  }

  static SearchC init() => GetIt.I.isRegistered<SearchC>()
      ? GetIt.I.get<SearchC>()
      : GetIt.I.registerSingleton<SearchC>(
          SearchC(),
          dispose: (sc) => sc.tec.dispose(),
        );

  void getLocalMovies() {
    final local = sp.getLocalMovies();
    for (Movie movie in local) {
      movies.indexWhere((e) => e.id == movie.id) == -1
          ? movies.add(movie)
          : movies[movies.indexWhere((e) => e.id == movie.id)] = movie;
    }
  }

  void loadMovies() {
    movies.observe((p0) {
      final List<Movie> newMovies = p0.list.toList();
      tec.clear();
      filteredMovies.clear();
      filteredMovies.addAll(newMovies);
      sp.saveLocalMovies(newMovies);
    });
    if (sp.isReady.value) getLocalMovies();
  }

  void dispose() {
    tec.dispose();
    GetIt.I.unregister<SearchC>();
  }
}
