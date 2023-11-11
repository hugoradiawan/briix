import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';

class ToastC {
  late FToast fToast;
  static init(BuildContext context) {
    final ToastC tc = ToastC();
    tc.fToast = FToast()..init(context);
    GetIt.I.registerSingleton<ToastC>(tc);
  }

  static void updateContext(BuildContext context) {
    GetIt.I.get<ToastC>().fToast = FToast()..init(context);
  }

  void showSucceedToast(String text) => fToast.showToast(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.greenAccent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check),
              const SizedBox(width: 12.0),
              Text(text),
            ],
          ),
        ),
        toastDuration: const Duration(seconds: 2),
      );

  void showErrorToast(String text) => fToast.showToast(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.redAccent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline),
              const SizedBox(
                width: 12.0,
              ),
              Text(text),
            ],
          ),
        ),
        toastDuration: const Duration(seconds: 2),
      );
}
