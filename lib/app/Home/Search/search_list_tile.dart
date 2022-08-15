import 'package:flutter/material.dart';

class SearchListTile extends StatelessWidget {
  const SearchListTile({
    Key key,
    @required this.program,
    @required this.onTap, this.type,
  }) : super(key: key);

  final program;
  final VoidCallback onTap;
  final Icon type;

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.black26,
          width: 1.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: _buildContent(program?.name ?? 'No Name'),
      trailing: type,
      onTap: onTap,
    );
  }

  Widget _buildContent(String name) {
    return Container(
      margin: EdgeInsets.only(
        left: 0.0,
        right: 0.0,
      ),
      //decoration: myBoxDecoration(),
      height: 50,
      child: new Text(
        name,
        style: TextStyle(fontSize: 18, color: Colors.grey[700],),
      ),
      alignment: Alignment(-1.0, 0.0),
    );
  }
}
