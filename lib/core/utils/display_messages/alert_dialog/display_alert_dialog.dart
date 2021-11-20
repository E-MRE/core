import 'package:flutter/material.dart';
import '/core/utils/display_messages/alert_dialog/error_alert_dialog.dart';
import '/core/utils/display_messages/alert_dialog/success_alert_dialog.dart';

class DisplayAlertDialog {
  late final BuildContext _context;
  static const String _successTitle = 'Başarılı';
  static const String _errorTitle = 'Hatalı';
  static const String _buttonText = 'OK';

  DisplayAlertDialog(BuildContext context) {
    _context = context;
  }

  Future<T?> successAlert<T>(
    String content, {
    String title = _successTitle,
    String buttonText = _buttonText,
    VoidCallback? onPressed,
  }) {
    return showDialog<T?>(
        context: _context,
        builder: (context) {
          return SuccessAlertDialog(
            title: title,
            content: content,
            buttonText: buttonText,
            onPressed: onPressed,
          );
        });
  }

  Future<T?> errorAlert<T>(
    String content, {
    String title = _errorTitle,
    String buttonText = _buttonText,
    VoidCallback? onPressed,
  }) {
    return showDialog<T?>(
        context: _context,
        builder: (context) {
          return ErrorAlertDialog(
            title: title,
            content: content,
            buttonText: buttonText,
            onPressed: onPressed,
          );
        });
  }
}
