import 'package:Azkar_Book/models/AdhkarModel.dart';
import 'package:Azkar_Book/screens/azkar_content.dart';
import 'package:flutter/material.dart';

class AdhkarList extends StatelessWidget {

  AdhkarList({this.adhkarFuture});

  final Future adhkarFuture;

  // adhkarFuture = AzkarService.getAdhkarList();
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: adhkarFuture,
      builder: (context, AsyncSnapshot snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Center(child: CircularProgressIndicator(backgroundColor: Colors.blue,));
          case ConnectionState.done:
            List<Adhkar> adhkars = snapshot.data;
            List<Adhkar> singleAdhkars = adhkars.where((test) => test.type == 0).toList();
            List<Adhkar> groupedAdhkars = adhkars.where((test) => test.type == 1).toList();
            // print(adhkars);/
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Single Adhkars', style: TextStyle(fontSize: 20, decoration: TextDecoration.underline),),
                  ),
                  Container(
                    child: (snapshot.hasData) ?
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: singleAdhkars.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Adhkar azikiri = singleAdhkars[index];
                          final int odd = index % 2 == 1 ? 1 : 0;
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChatScreen(
                                  zikiri: azikiri,
                                ),
                              ),
                            ),
                            child: Container(
                                margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
                                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                  color: odd == 1 ? Color(0xFFFFEFEE) : Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0),
                                  ),
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                azikiri.name,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 5.0),
                                              Container(
                                                width: MediaQuery.of(context).size.width *
                                                    0.45,
                                                child: Text(
                                                  azikiri.name,
                                                  style: TextStyle(
                                                    color: Colors.blueGrey,
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Lacquer',
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(children: <Widget>[
                                        // Text(
                                        //   'play',
                                        //   style: TextStyle(
                                        //     color: Colors.grey,
                                        //     fontSize: 15.0,
                                        //     fontWeight: FontWeight.bold,
                                        //   ),
                                        // ),
                                        IconButton(
                                          icon: Icon(Icons.chrome_reader_mode),
                                          iconSize: 15.0,
                                          color: Colors.red,
                                          onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => ChatScreen(
                                                zikiri: azikiri,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ])),
                          );
                        },
                      )
                    : Center(child: Text(snapshot.error.toString(),))
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Grouped Adhkars', style: TextStyle(fontSize: 20, decoration: TextDecoration.underline),),
                  ),
                  Container(
                    child: (snapshot.hasData) ?
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: groupedAdhkars.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Adhkar azikiri = groupedAdhkars[index];
                          final int odd = index % 2 == 1 ? 1 : 0;
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChatScreen(
                                  zikiri: azikiri,
                                ),
                              ),
                            ),
                            child: Container(
                                margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
                                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                  color: odd == 1 ? Color(0xFFFFEFEE) : Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0),
                                  ),
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                azikiri.name,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 5.0),
                                              Container(
                                                width: MediaQuery.of(context).size.width *
                                                    0.45,
                                                child: Text(
                                                  azikiri.name,
                                                  style: TextStyle(
                                                    color: Colors.blueGrey,
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Lacquer',
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(children: <Widget>[
                                        // Text(
                                        //   'play',
                                        //   style: TextStyle(
                                        //     color: Colors.grey,
                                        //     fontSize: 15.0,
                                        //     fontWeight: FontWeight.bold,
                                        //   ),
                                        // ),
                                        IconButton(
                                          icon: Icon(Icons.chrome_reader_mode),
                                          iconSize: 15.0,
                                          color: Colors.red,
                                          onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => ChatScreen(
                                                zikiri: azikiri,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ])),
                          );
                        },
                      )
                    : Center(child: Text(snapshot.error.toString(),))
                  ),
                ],
              ),
            );
        }
      }
    );
  }
}