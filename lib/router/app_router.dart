import 'package:auto_route/auto_route.dart';
import 'package:briix/movie_collection_page.dart';
import 'package:briix/movie_crud_page.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class RootRouter extends _$RootRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: "/movies", page: MovieCollectionRoute.page),
        AutoRoute(path: "/movie/:id", page: MovieCRUDRoute.page),
      ];
}
