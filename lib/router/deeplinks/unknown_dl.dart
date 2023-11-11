import 'package:auto_route/auto_route.dart';

class NotFoundRoute extends PageRouteInfo {
  const NotFoundRoute({List<PageRouteInfo>? children})
      : super(name, initialChildren: children);

  static const String name = 'UnknownRoute';
  static const PageInfo<void> page = PageInfo<void>(name);
}