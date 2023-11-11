import 'package:auto_route/auto_route.dart';

class MovieCollectionRoute extends PageRouteInfo {
  const MovieCollectionRoute({List<PageRouteInfo>? children})
      : super(name, initialChildren: children);

  static const String name = 'MovieCollectionRoute';
  static const PageInfo<void> page = PageInfo<void>(name);
}