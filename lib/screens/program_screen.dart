import 'package:Azkar_Book/screens/AzkarSearchDelegate.dart';
import 'package:Azkar_Book/widgets/HomeSideBar.dart';
import 'package:flutter/material.dart';

class ProgramScreen extends StatefulWidget {
  @override
  _ProgramScreenState createState() => _ProgramScreenState();
}

class _ProgramScreenState extends State<ProgramScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          'Programs',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {
              // showSearch(context: context, delegate: AzkarSearchDelegate(adhkarProvider: azkarProvider));
            },
          ),
        ],
      ),
      drawer: Drawer(
        elevation: 1.0,
        semanticLabel: 'Semantic Label',
        child: HomeSideBar(active: 'programs',)
      ),
      body: Column(
        children: <Widget>[
//          CategorySelector(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  // AdhkarList(adhkarFuture: adhkarFuture,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}