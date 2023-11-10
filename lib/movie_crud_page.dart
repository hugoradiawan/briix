import 'package:flutter/material.dart';

class MovieCRUDPage extends StatefulWidget {
  const MovieCRUDPage({super.key});

  @override
  State<MovieCRUDPage> createState() => _MovieCRUDPageState();
}

class _MovieCRUDPageState extends State<MovieCRUDPage> {
  @override
  Widget build(_) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.save),
            ),
          ],
        ),
        body: ListView(children: const [
          TextField(
            decoration: InputDecoration(
              labelText: 'Title',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Director',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Summary',
            ),
          ),
        ]),
      );
}