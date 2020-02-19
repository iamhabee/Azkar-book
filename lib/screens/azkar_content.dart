import 'dart:async';

import 'package:Azkar_Book/models/AdhkarModel.dart';
import 'package:Azkar_Book/models/Adhkars.dart';
import 'package:Azkar_Book/providers/AzkarProvider.dart';
import 'package:Azkar_Book/widgets/AdhkarAudioWidget.dart';
import 'package:Azkar_Book/widgets/GeneralViewWidget.dart';
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
    // azkarProvider = AzkarProvider(code: widget.zikiri.code);
    super.initState();
    azkarProvider = AzkarProvider(code: widget.zikiri.code);
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
            icon: Icon(Icons.translate),
            iconSize: 30.0,
            color: Colors.white,
            tooltip: 'Translate to english',
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: SideBar(code: widget.zikiri.code,),
      ),
      body: GestureDetector(
        child: Column(
          children: <Widget>[
            GeneralWidget(
              child: StreamBuilder<String>(
                stream: azkarProvider.azkarContent,
                builder: (context, AsyncSnapshot<String> snapshot) {
                  // print(snapshot.connectionState);
                  switch(snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      return Center(child: CircularProgressIndicator(backgroundColor: Colors.blue,));
                    case ConnectionState.done:
                      // print(snapshot.hasData);
                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString(), style: TextStyle(color: Colors.red)));
                      } else {
                        String str = (snapshot.hasData) ? snapshot.data.replaceAll('\n', '') : '';
                        List<String> adhkarContent = str.split('-').toList();
                        // print(adhkarContent.length);
                        return OverflowBox(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: adhkarContent.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                key: Key(index.toString()),
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    adhkarContent[index].toString(), 
                                    style: TextStyle(fontSize: 20, fontFamily: 'Montserrat', color: Colors.red[900]), 
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              );
                            }
                          ),
                        );
                      }
                      break;
                  }
                }
              ),
            ),
            Container(
              child: AdhkarAudioWidget(zikiri: widget.zikiri, type: 'adhkar',)
            )
          ],
        ),
      ),
      // bottomSheet: BottomSheet(
      //   onClosing: () {},
      //   builder: (context) {
      //     return Container(
      //       child: Center(
      //         child: CircularProgressIndicator()
      //       )
      //     );
      //   }
      // ),
    );
  }
}
