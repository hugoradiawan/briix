import 'package:briix/movie.dart';
import 'package:briix/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart' as mx;

class SearchC {
  final TextEditingController tec = TextEditingController();
  final SharedPref sp = GetIt.I.get<SharedPref>();
  final mx.Observable<List<Movie>> movies = mx.Observable([]),
      filteredMovies = mx.Observable([]);

  SearchC() {
    tec.addListener(() => mx.Action(() => _onTextChanged(tec.text))());
  }

  void _onTextChanged(String text) {
    if (text.isEmpty) {
      filteredMovies.value = movies.value;
      return;
    }
    filteredMovies.value = movies.value
        .where((e) => e.title.toLowerCase().contains(text.toLowerCase()))
        .toList();
  }

  static SearchC init() => GetIt.I.registerSingleton<SearchC>(
        SearchC(),
        dispose: (sc) => sc.tec.dispose(),
      );

  void getLocalMovies() {
    movies.value = sp.getLocalMovies();
    filteredMovies.value = movies.value;
  }

  void loadMovies() {
    if (sp.isReady.value) {
      getLocalMovies();
    }
    sp.isReady.observe((p0) {
      if (p0.newValue ?? false) return;
      getLocalMovies();
    });
  }

  void dispose() {
    tec.dispose();
    GetIt.I.unregister<SearchC>();
  }
}
