import 'package:flutter/services.dart';
import 'platform_alert_dialog.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  final String title;
  final PlatformException exception;

  PlatformExceptionAlertDialog({
    required this.title,
    required this.exception,
  }) : super(
          title: title,
          content: _getMessage(exception),
          cancelTextButton: 'OK',
        );

  static String _getMessage(PlatformException exception) {
    return _errors[exception.code] ?? exception.message.toString();
  }

  static final Map<String, String> _errors = {
    //TODO:: complete all Exceptions => https://firebase.google.com/docs/auth/admin/errors;
    'claims-too-large':
        'The claims payload provided to setCustomUserClaims() exceeds the maximum allowed size of 1000 bytes.',
    'invalid-email':
        'The provided value for the email user property is invalid. It must be a string email address.',
  };
}
