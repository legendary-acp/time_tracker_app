import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timetrackerapp/custom_widget/platform_widget.dart';

class PlatformAlertDialog extends PlatformWidget {
  PlatformAlertDialog(
      {@required this.title,
      @required this.content,
        this.cancelActionText,
      @required this.defaultActionText})
      : assert(title != null),
        assert(content != null),
        assert(defaultActionText != null);

  final String title;
  final String content;
  final String cancelActionText;
  final String defaultActionText;

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog(
            context: context, builder: (context) => this)
        : await showDialog<bool>(
            context: context,
            builder: (context) => this,
          );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      content: Text(content),
      title: Text(title),
      actions: _buildAction(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildAction(context),
    );
  }

  List<Widget> _buildAction(BuildContext context) {
    final action = <Widget>[];
    if(cancelActionText!=null) {
      action.add(
          PlatformAlertDialogAction(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(cancelActionText))
      );
    }
      action.add(
          PlatformAlertDialogAction(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(defaultActionText))
      );
    return action;
  }
}

class PlatformAlertDialogAction extends PlatformWidget {
  PlatformAlertDialogAction({this.child, this.onPressed});

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return FlatButton(
      child: child,
      onPressed: onPressed,
    );
  }


}

class PlatformExceptionAlertDialog extends PlatformAlertDialog {

  static String message(PlatformException exception) {
    if (exception.message == 'FIRFirestoreErrorDomain') {
      if (exception.code == 'Error 7') {
        return 'Missing or insufficient permissions';
      }
    }
    return _errors[exception.code] ?? exception.message;
  }

  static Map<String, String> _errors = {
    'ERROR_WEAK_PASSWORD': 'If the password is not strong enough.',
    'ERROR_INVALID_CREDENTIAL': 'Invalid Credential',
    'ERROR_EMAIL_ALREADY_IN_USE': 'Email already associated with different account.',
    'ERROR_INVALID_EMAIL': 'Invalid email address is malformed.',
    'ERROR_WRONG_PASSWORD': 'Invalid password',
    'ERROR_USER_NOT_FOUND': 'User not found.',
    'ERROR_USER_DISABLED': 'User has been disabled (Contact Developers)',
    'ERROR_TOO_MANY_REQUESTS': 'There are too many attempts to sign in as this user.',
    'ERROR_OPERATION_NOT_ALLOWED': 'Email & Password accounts are not enabled.',
  };
}