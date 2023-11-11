import 'package:briix/configs/shared_pref.dart';
import 'package:briix/router/app_router.dart';
import 'package:briix/router/briix_app.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  RootRouter.init();
  await SharedPref.init();
  runApp(const BriixApp());
}
