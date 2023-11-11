import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:briix/movie.dart';
import 'package:briix/search_c.dart';
import 'package:briix/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class MovieCRUDC {
  MovieCRUDC({this.id});
  final SearchC sc = GetIt.I.get<SearchC>();
  final TextEditingController titleTec = TextEditingController(),
      directorTec = TextEditingController(),
      summaryTec = TextEditingController();
  final FToast fToast = FToast();
  final ObservableList<String> genres = ObservableList(),
      selectedGenres = ObservableList();

  final String? id;

  void init(BuildContext context) {
    fToast.init(context);
    genres.clear();
    genres.addAll(GetIt.I.get<SharedPref>().getLocalGenres());
    if (id == null) return;
    print('id: $id');
    print('movies: ${sc.movies.length}');
    if (sc.movies.isEmpty) {
      final local = GetIt.I.get<SharedPref>().getLocalMovies();
      print('local: ${local.length}');
      sc.movies.addAll(local);
    }
    print('movies 111: ${sc.movies.length}');
    final Movie tempMovie =
        sc.movies.firstWhere((Movie movie) => movie.id == id);
    titleTec.text = tempMovie.title;
    directorTec.text = tempMovie.director;
    summaryTec.text = tempMovie.summary;
    selectedGenres.addAll(tempMovie.genres);
  }

  void delete() {
    if (id == null) return;
    final int index = sc.movies.indexWhere((e) => e.id == id);
    if (index == -1) return;
    sc.movies.removeAt(index);
  }

  void onGenreSelected(String genre) {
    if (selectedGenres.contains(genre)) {
      selectedGenres.remove(genre);
    } else {
      selectedGenres.add(genre);
    }
  }

  void showErrorToast(String text) => fToast.showToast(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.redAccent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline),
              const SizedBox(
                width: 12.0,
              ),
              Text(text),
            ],
          ),
        ),
        toastDuration: const Duration(seconds: 2),
      );

  void showSucceedToast(String text) => fToast.showToast(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.greenAccent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check),
              const SizedBox(width: 12.0),
              Text(text),
            ],
          ),
        ),
        toastDuration: const Duration(seconds: 2),
      );

  void save(BuildContext context) {
    // if (titleTec.text.isEmpty) {
    //   showErrorToast('Title is required');
    //   return;
    // }
    // if (directorTec.text.isEmpty) {
    //   showErrorToast('Director is required');
    //   return;
    // }
    // if (summaryTec.text.isEmpty) {
    //   showErrorToast('Summary is required');
    //   return;
    // }
    // if (summaryTec.text.length > 100) {
    //   showErrorToast('Summary is too long');
    //   return;
    // }
    // if (selectedGenres.isEmpty) {
    //   showErrorToast('At least one genre is required');
    //   return;
    // }
    // final Movie newMovie = Movie(
    //   id: randomString(10),
    //   title: titleTec.text,
    //   director: directorTec.text,
    //   summary: summaryTec.text,
    //   genres: selectedGenres.toList(),
    // );
    // if (index == null) {
    //   sc.movies.add(newMovie);
    // } else {
    //   sc.movies[index!] = newMovie;
    // }
    AutoRouter.of(context).pop();
  }

  String randomString(int length) {
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
