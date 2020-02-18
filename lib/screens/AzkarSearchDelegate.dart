
import 'package:Azkar_Book/models/AdhkarModel.dart';
import 'package:Azkar_Book/providers/AzkarProvider.dart';
import 'package:Azkar_Book/screens/azkar_content.dart';
import 'package:flutter/material.dart';

class AzkarSearchDelegate extends SearchDelegate {
  AzkarSearchDelegate({this.adhkarProvider});

  final AzkarProvider adhkarProvider;
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () {})
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    if (query.length <= 1) {
      return Center(
        child: Text('Type more than 3 character'),
      );
    }
    return _buildResultList(adhkarProvider: adhkarProvider, q: query,);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Container(
      child: Text(query)
    );
  }
  
}

class _buildResultList extends StatelessWidget {
  const _buildResultList({
    Key key,
    @required this.adhkarProvider,
    @required this.q,
  }) : super(key: key);

  final AzkarProvider adhkarProvider;
  final String q;

  @override
  Widget build(BuildContext context) {
    print(q);
    return StreamBuilder(
      stream: adhkarProvider.filteredCollection(searchParam: q),
      builder: (context, AsyncSnapshot snapshot) {
        print(snapshot.data);
        switch(snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Center(child: CircularProgressIndicator());
            break;
          case ConnectionState.done:
            List<Adhkar> adhkars = snapshot.data;
            // List<Adhkar> adhkars = res.map((f) => f.name.contains(query)).toList();
            return (!snapshot.hasData) ? Center(child: CircularProgressIndicator()) : ListView.builder(
              itemCount: adhkars.length,
              itemBuilder: (BuildContext context, int index) {
                final Adhkar azikiri = adhkars[index];
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(children: <Widget>[
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
            );
        }
      }
    );
  }
}