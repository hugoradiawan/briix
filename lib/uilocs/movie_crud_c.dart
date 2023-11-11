import 'dart:math';

import 'package:briix/blocs/movie.dart';
import 'package:briix/configs/shared_pref.dart';
import 'package:briix/router/app_router.dart';
import 'package:briix/uilocs/search_c.dart';
import 'package:briix/uilocs/toast_c.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class MovieCRUDC {
  MovieCRUDC({this.id});
  final MovieCollectionC mcc = GetIt.I.get<MovieCollectionC>();
  final TextEditingController titleTec = TextEditingController(),
      directorTec = TextEditingController(),
      summaryTec = TextEditingController();
  final ObservableList<String> genres = ObservableList(),
      selectedGenres = ObservableList();
  final ToastC tc = GetIt.I.get<ToastC>();

  final String? id;

  void init() {
    final SharedPref sp = GetIt.I.get<SharedPref>();
    genres.clear();
    genres.addAll(sp.getLocalGenres());
    if (id == null) return;
    if (mcc.movies.isEmpty) {
      final local = sp.getLocalMovies();
      mcc.movies.addAll(local);
    }
    final Movie tempMovie =
        mcc.movies.firstWhere((Movie movie) => movie.id == id);
    titleTec.text = tempMovie.title;
    directorTec.text = tempMovie.director;
    summaryTec.text = tempMovie.summary;
    selectedGenres.addAll(tempMovie.genres);
  }

  void delete() {
    if (id == null) return;
    final int index = mcc.movies.indexWhere((e) => e.id == id);
    if (index == -1) return;
    mcc.movies.removeAt(index);
    _back();
  }

  void onGenreSelected(String genre) => selectedGenres.contains(genre)
      ? selectedGenres.remove(genre)
      : selectedGenres.add(genre);

  void _back() => GetIt.I.get<RootRouter>().pop();

  void save() {
    if (titleTec.text.isEmpty) {
      tc.showErrorToast('Title is required');
      return;
    }
    if (directorTec.text.isEmpty) {
      tc.showErrorToast('Director is required');
      return;
    }
    if (summaryTec.text.isEmpty) {
      tc.showErrorToast('Summary is required');
      return;
    }
    if (summaryTec.text.length > 100) {
      tc.showErrorToast('Summary is too long');
      return;
    }
    if (selectedGenres.isEmpty) {
      tc.showErrorToast('At least one genre is required');
      return;
    }
    final Movie newMovie = Movie(
      id: _randomString(10),
      title: titleTec.text,
      director: directorTec.text,
      summary: summaryTec.text,
      genres: selectedGenres.toList(),
    );
    if (id == null) {
      mcc.movies.add(newMovie);
    } else {
      final int index = mcc.movies.indexWhere((e) => e.id == id);
      if (index == -1) return;
      mcc.movies[index] = newMovie;
    }
    tc.showSucceedToast("Movie saved");
    _back();
  }

  String _randomString(int length) {
    const String chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
    final StringBuffer buf = StringBuffer();
    for (int x = 0; x < length; x++) {
      buf.write(chars[rnd.nextInt(chars.length)]);
    }
    return buf.toString();
  }

  void dispose() {
    titleTec.dispose();
    directorTec.dispose();
    summaryTec.dispose();
    GetIt.I.unregister<MovieCRUDC>(instanceName: id);
  }
}
