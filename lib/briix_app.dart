import 'package:briix/movie_collection_page.dart';
import 'package:flutter/material.dart';

class BriixApp extends StatelessWidget {
  const BriixApp({super.key});

  @override
  Widget build(_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Briix Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.lightBlue,
          ),
          useMaterial3: true,
        ),
        home: const MovieCollectionPage(),
      );
}
