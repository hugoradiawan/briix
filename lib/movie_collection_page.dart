import 'package:briix/movie_tile.dart';
import 'package:briix/search_c.dart';
import 'package:briix/shared_pref.dart';
import 'package:briix/test_movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class MovieCollectionPage extends StatefulWidget {
  const MovieCollectionPage({super.key});

  @override
  State<MovieCollectionPage> createState() => _MovieCollectionPageState();
}

class _MovieCollectionPageState extends State<MovieCollectionPage> {
  late SearchC sc;
  @override
  void initState() {
    sc = SearchC.init()..loadMovies();
    super.initState();
  }

  @override
  Widget build(_) => Scaffold(
        appBar: AppBar(
          title: const Text('Movie Collection'),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
          onPressed: () =>
              GetIt.I.get<SharedPref>().saveLocalMovies(testMovies),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: sc.tec,
                decoration: const InputDecoration(
                  hintText: 'Search By Title',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Observer(
                    builder: (_) => Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        for (int i = 0; i < sc.filteredMovies.value.length; i++)
                          MovieTile(sc.filteredMovies.value[i])
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );

  @override
  void dispose() {
    sc.dispose();
    super.dispose();
  }
}
