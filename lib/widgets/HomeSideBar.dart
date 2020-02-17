import 'package:Azkar_Book/widgets/SideBarUserAccount.dart';
import 'package:flutter/material.dart';

class HomeSideBar extends StatefulWidget {
  HomeSideBar({this.code});

  final String code;
  @override
  _HomeSideBarState createState() => _HomeSideBarState();
}

class _HomeSideBarState extends State<HomeSideBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          // Padding(padding: const EdgeInsets.only(top: 16.0),),
          SideBarUseraccount(),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
          )
        ],
      ),
    );
  }
}