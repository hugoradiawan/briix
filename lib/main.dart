import 'package:briix/briix_app.dart';
import 'package:briix/shared_pref.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  runApp(const BriixApp());
}
