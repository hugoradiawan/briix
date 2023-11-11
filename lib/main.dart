import 'package:briix/router/app_router.dart';
import 'package:briix/router/briix_app.dart';
import 'package:briix/configs/shared_pref.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  RootRouter.init();
  await SharedPref.init();
  runApp(const BriixApp());
}
