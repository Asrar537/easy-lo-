import 'dart:io';
import 'package:easy_lo/common/Platform_widget/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupPlatformAlertDialog extends PlatformWidget {
  CupPlatformAlertDialog({
    @required this.title,
    @required this.content,
    @required this.defaultActionText,
    this.cancleActionText,
  }) : assert(title != null && content != null && defaultActionText != null);

  final String title;
  final String content;
  final String defaultActionText;
  final String cancleActionText;

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog(
            context: context,
            builder: (context) => this,
          )
        : await showDialog<bool>(
            context: context,
            builder: (context) => this,
          );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return Container();
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(title),
      message: Text(content),
      actions: _buildCupertinoActions(context),
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          cancleActionText,
        ),
        onPressed: () => Navigator.of(context).pop(true),
      ),
    );
  }

  List<Widget> _buildCupertinoActions(BuildContext context) {
    return [
      CupertinoActionSheetAction(
        child: Text(defaultActionText),
        onPressed: () => Navigator.of(context).pop(true),
      ),
    ];
  }
}

class CupertinoActionSheetAction extends PlatformWidget {
  CupertinoActionSheetAction({this.child, this.onPressed});
  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return null;
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return CupertinoActionSheetAction(
      child: child,
      onPressed: onPressed,
    );
  }
}
