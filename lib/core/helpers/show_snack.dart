import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

void showSnack({
  required BuildContext context,
  required String title,
  required String message,
  required ContentType type,
}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (context.mounted) {
      final snackBar = SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        content: AwesomeSnackbarContent(
          title: title,
          message: message,
          contentType: type,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  });
}
