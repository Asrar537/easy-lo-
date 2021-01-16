import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({Key key, @required this.buildContent})
      : super(key: key);
  final Widget buildContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(225, 255, 247, 1),
        // gradient: LinearGradient(
        //   colors: [
        //     Color.fromRGBO(32, 168, 151, 1),
        //     Color.fromRGBO(225, 255, 247, 1),
        //   ]
        // ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: buildContent,
    );
  }
}
