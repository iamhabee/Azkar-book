import 'package:flutter/material.dart';

class LectureScreen extends StatefulWidget {
  @override
  _LectureScreenState createState() => _LectureScreenState();
}

class _LectureScreenState extends State<LectureScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Lectures'),)
    );
  }
}