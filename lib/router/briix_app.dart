import 'package:auto_route/auto_route.dart';
import 'package:briix/router/app_router.dart';
import 'package:flutter/material.dart';

class BriixApp extends StatelessWidget {
  const BriixApp({super.key});

  @override
  Widget build(_) {
    final rootRouter = RootRouter();
    return MaterialApp.router(
      routerConfig: rootRouter.config(
        deepLinkBuilder: (dl) {
          return DeepLink([
            const MovieCollectionRoute(),
            if (dl.uri.pathSegments.contains('movie'))
              MovieCRUDRoute(id: dl.uri.pathSegments[1]),
          ]);
        },
      ),
      debugShowCheckedModeBanner: false,
      title: 'Briix Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
        ),
        useMaterial3: true,
      ),
    );
  }
}
