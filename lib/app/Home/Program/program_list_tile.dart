import 'package:easy_lo/app/Home/module/program_module.dart';
import 'package:flutter/material.dart';

class ProgramListTile extends StatelessWidget {
  const ProgramListTile({
    Key key,
    @required this.program,
    @required this.onTap,
  }) : super(key: key);

  final ProgramModule program;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FlutterLogo(),
      title: Text(program.name != null ? program.name : 'No Name'),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
