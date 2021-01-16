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
    return Container(
      margin: EdgeInsets.only(bottom: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          program?.name ?? 'No Name',
          style: TextStyle(
            color: Color.fromRGBO(32, 168, 151, 1),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
