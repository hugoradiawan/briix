import 'package:auto_route/auto_route.dart';
import 'package:briix/movie_crud_page.dart';
import 'package:briix/movie_tile.dart';
import 'package:briix/search_c.dart';
import 'package:briix/test_movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart' as mx;

@RoutePage()
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
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const MovieCRUDPage(),
            ),
          ),
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
                    builder: (_) => sc.filteredMovies.isNotEmpty
                        ? Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              for (int i = 0; i < sc.filteredMovies.length; i++)
                                MovieTile(i)
                            ],
                          )
                        : SizedBox(
                            height: 400,
                            child: Center(
                              child: ElevatedButton(
                                child: const Text('Load Test Data'),
                                onPressed: () => mx.Action(
                                    () => sc.movies.addAll(testMovies))(),
                              ),
                            ),
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
