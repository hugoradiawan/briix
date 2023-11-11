import 'package:briix/movie_crud_c.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

class MovieCRUDPage extends StatefulWidget {
  const MovieCRUDPage({this.index, super.key});

  final int? index;

  @override
  State<MovieCRUDPage> createState() => _MovieCRUDPageState();
}

class _MovieCRUDPageState extends State<MovieCRUDPage> {
  late MovieCRUDC mc;

  @override
  void didChangeDependencies() {
    mc = GetIt.I.registerSingleton<MovieCRUDC>(MovieCRUDC(index: widget.index))
      ..init(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(_) => Scaffold(
        appBar: AppBar(
          actions: [
            if (widget.index != null)
              IconButton(
                onPressed: mc.delete,
                icon: const Icon(Icons.delete),
              ),
            IconButton(
              onPressed: mc.save,
              icon: const Icon(Icons.save),
            ),
            const Gap(10),
          ],
        ),
        body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: [
              TextField(
                controller: mc.titleTec,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter the movie\'s title',
                ),
              ),
              const Gap(10),
              TextField(
                controller: mc.directorTec,
                decoration: const InputDecoration(
                  labelText: 'Director',
                  hintText: 'Enter the director\'s name',
                ),
              ),
              const Gap(10),
              TextField(
                maxLines: 5,
                minLines: 3,
                maxLength: 100,
                controller: mc.summaryTec,
                decoration: const InputDecoration(
                    labelText: 'Summary', hintText: 'Enter a short summary'),
              ),
              Observer(
                builder: (_) => Wrap(
                  children: [
                    for (int i = 0; i < mc.genres.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ChoiceChip(
                          selected: mc.selectedGenres.contains(mc.genres[i]),
                          onSelected: (_) => mc.onGenreSelected(mc.genres[i]),
                          label: Text(mc.genres[i]),
                        ),
                      ),
                  ],
                ),
              ),
            ]),
      );

  @override
  void dispose() {
    mc.dispose();
    super.dispose();
  }
}
