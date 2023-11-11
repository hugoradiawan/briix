import 'package:auto_route/auto_route.dart';
import 'package:briix/uis/movie_collection_page.dart';
import 'package:briix/uis/movie_crud_page.dart';
import 'package:briix/uis/not_found_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class RootRouter extends _$RootRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: "*", page: NotFoundRoute.page),
        AutoRoute(
            path: "/movies", page: MovieCollectionRoute.page, initial: true),
        AutoRoute(path: "/movie/:id", page: MovieCRUDRoute.page),
      ];

  static void init() {
    GetIt.I.registerSingleton<RootRouter>(RootRouter());
  }
}
