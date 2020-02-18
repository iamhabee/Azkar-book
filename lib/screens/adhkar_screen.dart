import 'package:Azkar_Book/models/AdhkarModel.dart';
import 'package:Azkar_Book/providers/AzkarProvider.dart';
import 'package:Azkar_Book/screens/AzkarSearchDelegate.dart';
import 'package:Azkar_Book/service/AzkarService.dart';
import 'package:Azkar_Book/widgets/GeneralViewWidget.dart';
import 'package:Azkar_Book/widgets/HomeSideBar.dart';
import 'package:flutter/material.dart';
import 'package:Azkar_Book/widgets/list_azkhar.dart';

class AdhkarScreen extends StatefulWidget {
  @override
  _AdhkarScreenState createState() => _AdhkarScreenState();
}

class _AdhkarScreenState extends State<AdhkarScreen> {
  Future<List<Adhkar>> adhkarFuture = AzkarService.getAdhkarList();
  AzkarProvider azkarProvider = AzkarProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          'Adhkar',
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
              showSearch(context: context, delegate: AzkarSearchDelegate(adhkarProvider: azkarProvider));
            },
          ),
        ],
      ),
      drawer: Drawer(
        elevation: 1.0,
        semanticLabel: 'Semantic Label',
        child: HomeSideBar(active: 'adhkar')
      ),
      body: Column(
        children: <Widget>[
          GeneralWidget(
            child: AdhkarList(adhkarFuture: adhkarFuture,),
          )
        ],
      ),
    );
  }
}
