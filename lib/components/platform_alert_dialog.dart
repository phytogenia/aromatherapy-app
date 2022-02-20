import 'dart:io';

import 'package:aromatherapy/components/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformAlertDialog extends PlatformWidget {
  final String title;
  final String content;
  final String? agreeTextButton;
  final String cancelTextButton;

  PlatformAlertDialog({
    this.agreeTextButton,
    required this.cancelTextButton,
    required this.title,
    required this.content,
  });

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return this;
            })
        : await showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return this;
            });
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    List<Widget> tmpListActions = [];
    tmpListActions.add(
      PlatformAlertDialogAction(
        onPressed: () {
          Navigator.pop(context, false);
        },
        child: Text(cancelTextButton),
      ),
    );

    if (agreeTextButton != null) {
      tmpListActions.add(
        PlatformAlertDialogAction(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text(agreeTextButton!),
        ),
      );
    }
    return tmpListActions;
  }
}

class PlatformAlertDialogAction extends PlatformWidget {
  final Function onPressed;
  final Widget child;

  PlatformAlertDialogAction({
    required this.onPressed,
    required this.child,
  });

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      child: child,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      child: child,
    );
  }
}
