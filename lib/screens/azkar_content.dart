import 'dart:async';

import 'package:Azkar_Book/models/AdhkarModel.dart';
import 'package:Azkar_Book/models/Adhkars.dart';
import 'package:Azkar_Book/providers/AzkarProvider.dart';
import 'package:Azkar_Book/widgets/SideBar.dart';
import 'package:flutter/material.dart';

import 'AzkarSearchDelegate.dart';


class ChatScreen extends StatefulWidget {
  final Adhkar zikiri;

  ChatScreen({this.zikiri});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  
  AzkarProvider azkarProvider;

  @override
  void initState() {
    // TODO: implement initState
    azkarProvider = AzkarProvider(code: widget.zikiri.text_path);
    super.initState();
    azkarProvider = AzkarProvider(code: widget.zikiri.text_path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          widget.zikiri.name,
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.play_arrow),
            iconSize: 30.0,
            color: Colors.white,
            tooltip: 'Play audio',
            onPressed: () {
              
            },
          ),
          IconButton(
            icon: Icon(Icons.translate),
            iconSize: 30.0,
            color: Colors.white,
            tooltip: 'Translate to english',
            onPressed: () {
              
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: SideBar(code: widget.zikiri.code,),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
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
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: StreamBuilder<String>(
                        stream: azkarProvider.azkarContent,
                        builder: (context, AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          } else {
                            return Text(snapshot.data.toString(), style: TextStyle(fontSize: 20, fontFamily: 'Montserrat',));
                          }
                        }
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
