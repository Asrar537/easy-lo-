import 'package:flutter/material.dart';

class ProgramListTile extends StatelessWidget {
  const ProgramListTile({
    Key key,
    @required this.program,
    @required this.onTap,
    this.leading,
  }) : super(key: key);

  final program;
  final VoidCallback onTap;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(program?.name ?? 'No Name'),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
