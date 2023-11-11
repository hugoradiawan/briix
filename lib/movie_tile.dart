import 'package:briix/movie.dart';
import 'package:briix/movie_crud_page.dart';
import 'package:briix/search_c.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MovieTile extends StatelessWidget {
  const MovieTile(this.index, {super.key});

  final int index;
  @override
  Widget build(BuildContext context) {
    final Movie movie = GetIt.I.get<SearchC>().filteredMovies[index];
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => MovieCRUDPage(index: index))),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.all(8),
        height: 200,
        width: 400,
        child: Column(children: [
          ListTile(
            title: Text(movie.title),
            subtitle: Text(movie.director),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Wrap(
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  for (int i = 0; i < movie.genres.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Chip(
                        label: Text(movie.genres[i]),
                      ),
                    ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
