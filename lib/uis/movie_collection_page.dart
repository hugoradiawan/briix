import 'package:auto_route/auto_route.dart';
import 'package:briix/configs/shared_pref.dart';
import 'package:briix/router/app_router.dart';
import 'package:briix/test_data.dart';
import 'package:briix/uilocs/search_c.dart';
import 'package:briix/uis/movie_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart' as mx;

@RoutePage()
class MovieCollectionPage extends StatefulWidget {
  const MovieCollectionPage({super.key});

  @override
  State<MovieCollectionPage> createState() => _MovieCollectionPageState();
}

class _MovieCollectionPageState extends State<MovieCollectionPage> {
  late MovieCollectionC sc;
  @override
  void initState() {
    sc = MovieCollectionC.init()..loadMovies();
    super.initState();
  }

  @override
  Widget build(_) => Scaffold(
        appBar: AppBar(
          title: InkWell(
            child: const Text('Movie Collection'),
            onTap: () =>
                print(GetIt.I.get<SharedPref>().prefs.getString('movies')),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
          onPressed: () => GetIt.I.get<RootRouter>().push(MovieCRUDRoute()),
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
