import 'package:easy_lo/app/Home/module/program_sallybus_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabelFromData extends StatelessWidget {
  const TabelFromData({Key key, this.data}) : super(key: key);

  final ProgramSallybusModule data;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildContent(),
      ),
    );
  }

  List<Widget> _buildContent() {
    List<Widget> _result = List();
    _result.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Sequence',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  'Detail',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                ),
              ],
            ),
          )
        ],
      ),
    );
    for (int i = 0; i < data.detail.length; i++) {
      _result.add(
        Divider(
          color: Colors.black12,
        ),
      );
      _result.add(Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: Text(data.head + ' ' + (i + 1).toString())),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 105,
              ),
              Expanded(child: Text(data.detail[i])),
            ],
          )
        ],
      ));
    }
    return _result;
  }
}
