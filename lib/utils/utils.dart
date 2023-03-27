import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(BuildContext context, String title) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(title)),
      );
  }

  static void showLoader() {
    BotToast.showCustomLoading(toastBuilder: (_) => CircularProgressIndicator.adaptive());
  }

  static void removeLoader() {
    BotToast.closeAllLoading();
  }
}
