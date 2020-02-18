import 'package:Azkar_Book/screens/adhkar_screen.dart';
import 'package:Azkar_Book/screens/branch_screen.dart';
import 'package:Azkar_Book/screens/events_screen.dart';
import 'package:Azkar_Book/screens/lecture_screen.dart';
import 'package:Azkar_Book/screens/program_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // context.inheritFromWidgetOfExactType(targetType)
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/logo.png'),
          ),
        ),
        title: Text(
          'The Academy',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    children: <Widget>[
                      GridChild(
                        text: Text('Adhkar', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),),
                        image: 'adhkar',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => AdhkarScreen()));
                        },
                      ),
                      GridChild(
                        text: Text('Events', style: TextStyle(fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold),),
                        image: 'events',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => EventScreen() ));
                        },
                      ),
                      // GridChild(
                      //   text: Text('Programs', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),),
                      //   image: 'programs',
                      //   onTap: () {
                      //     Navigator.push(context, MaterialPageRoute(builder: (_) => ProgramScreen()));
                      //   },
                      // ),
                      GridChild(
                        text: Text('Lectures', style: TextStyle(fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold),),
                        image: 'lectures',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => LectureScreen()));
                        },
                      ),
                      GridChild(
                        text: Text('Branches', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),),
                        image: 'branches',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => BranchScreen()));
                        },
                      ),
                      GridChild(
                        text: Text('About Us', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GridChild extends StatelessWidget {
  GridChild({Key key, this.text, this.onTap, this.image}) : super(key: key);

  final Widget text;
  final Function onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    String image_path = (image != null && image.isNotEmpty && image.toString().length > 0) ? 'assets/images/'+image.toString()+'.png' : 'assets/images/logo.png';
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: AlignmentDirectional.bottomCenter,
        padding: const EdgeInsets.all(8),
        child: text,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image_path)),
          border: Border.all(
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue,
              blurRadius: 2.0, // has the effect of softening the shadow
              spreadRadius: 1.0, // has the effect of extending the shadow
              offset: Offset(
                1.0, // horizontal, move right 10
                1.0, // vertical, move down 10
              ),
            )
          ],
        ),
      ),
    );
  }
}