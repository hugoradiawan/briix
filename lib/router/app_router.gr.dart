// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$RootRouter extends RootStackRouter {
  // ignore: unused_element
  _$RootRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    MovieCRUDRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MovieCRUDRouteArgs>(
          orElse: () => MovieCRUDRouteArgs(id: pathParams.optString('id')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MovieCRUDPage(
          id: args.id,
          key: args.key,
        ),
      );
    },
    MovieCollectionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MovieCollectionPage(),
      );
    },
  };
}

/// generated route for
/// [MovieCRUDPage]
class MovieCRUDRoute extends PageRouteInfo<MovieCRUDRouteArgs> {
  MovieCRUDRoute({
    String? id,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          MovieCRUDRoute.name,
          args: MovieCRUDRouteArgs(
            id: id,
            key: key,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'MovieCRUDRoute';

  static const PageInfo<MovieCRUDRouteArgs> page =
      PageInfo<MovieCRUDRouteArgs>(name);
}

class MovieCRUDRouteArgs {
  const MovieCRUDRouteArgs({
    this.id,
    this.key,
  });

  final String? id;

  final Key? key;

  @override
  String toString() {
    return 'MovieCRUDRouteArgs{id: $id, key: $key}';
  }
}

/// generated route for
/// [MovieCollectionPage]
class MovieCollectionRoute extends PageRouteInfo<void> {
  const MovieCollectionRoute({List<PageRouteInfo>? children})
      : super(
          MovieCollectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'MovieCollectionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
