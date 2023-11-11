import 'package:auto_route/auto_route.dart';

class MovieCRUDRoute extends PageRouteInfo {
  const MovieCRUDRoute({List<PageRouteInfo>? children})
      : super(name, initialChildren: children);

  static const String name = 'MovieCRUDRoute';
  static const PageInfo<void> page = PageInfo<void>(name);
}