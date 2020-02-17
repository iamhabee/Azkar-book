import 'package:Azkar_Book/models/AdhkarModel.dart';
import 'package:Azkar_Book/models/Adhkars.dart';
import 'package:Azkar_Book/screens/azkar_content.dart';
import 'package:Azkar_Book/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  SideBar({this.code});

  final String code;
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  List<Adhkar> zikrs = adhkars;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          DrawerHeader(
            child: Text('List Of Adhkar'),
          ),
          ListTile(
            title: Text('Home', style: TextStyle(fontSize: 20 ,color: Colors.red[900]),),
            leading: Icon(Icons.home),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => HomeScreen(),
              ),
            ),
          ),
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: zikrs.length,
              itemBuilder: (context, index) {
                Adhkar zikr = zikrs[index];
                return ListTile(
                  title: Text(zikr.name, style: TextStyle(fontSize: 20 ,color: (zikr.code == widget.code) ? Colors.red[900] : Colors.redAccent[100]),),
                  leading: Icon(Icons.library_books),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        zikiri: zikr,
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}