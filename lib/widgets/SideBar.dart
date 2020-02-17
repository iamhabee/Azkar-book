import 'package:Azkar_Book/models/AdhkarModel.dart';
import 'package:Azkar_Book/screens/azkar_content.dart';
import 'package:Azkar_Book/screens/home_screen.dart';
import 'package:Azkar_Book/service/AzkarService.dart';
import 'package:Azkar_Book/widgets/SideBarUserAccount.dart';
import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  SideBar({this.code});

  final String code;
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  Future<List<Adhkar>> adhkarFuture = AzkarService.getAdhkarList();

  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SideBarUseraccount(),
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
            child: FutureBuilder(
              future: AzkarService.getAdhkarList(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return Center(child: CircularProgressIndicator());
                    break;
                  case ConnectionState.done:
                    List<Adhkar> zikrs = snapshot.data;
                    print(zikrs);
                    return ListView.builder(
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
                  );
                }
              },
            )
            
            
            
          ),
        ],
      ),
    );
  }
}