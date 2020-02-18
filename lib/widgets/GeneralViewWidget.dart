import 'package:flutter/material.dart';


class GeneralWidget extends StatelessWidget {
  GeneralWidget({this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: Container(
            // padding: const EdgeInsets.all(16.0),
            child: child,
          ),
        ),
      ),
    );
  }
}