import 'package:Azkar_Book/screens/adhkar_screen.dart';
import 'package:Azkar_Book/screens/events_screen.dart';
import 'package:Azkar_Book/screens/home_screen.dart';
import 'package:Azkar_Book/screens/program_screen.dart';
import 'package:Azkar_Book/widgets/SideBarUserAccount.dart';
import 'package:flutter/material.dart';

class HomeSideBar extends StatefulWidget {
  HomeSideBar({this.active});

  final String active;
  @override
  _HomeSideBarState createState() => _HomeSideBarState();
}

class _HomeSideBarState extends State<HomeSideBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[100],
      child: Column(
        children: <Widget>[
          // Padding(padding: const EdgeInsets.only(top: 16.0),),
          SideBarUseraccount(),
          Padding(padding: const EdgeInsets.only(top: 30.0)),
          GeneralSideBarTile(text: 'Home', icon: Icons.home, isActive: (widget.active == 'home'), onTap: () => Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst)),
          GeneralSideBarTile(text: 'Azkar', icon: Icons.book, isActive: (widget.active == 'adhkar'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdhkarScreen())),),
          GeneralSideBarTile(text: 'Events', icon: Icons.place, isActive: (widget.active == 'events'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EventScreen())),),
          GeneralSideBarTile(text: 'Programs', icon: Icons.schedule, isActive: (widget.active == 'programs'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProgramScreen())),),
          GeneralSideBarTile(text: 'About Us', icon: Icons.info, isActive: (widget.active == 'about'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProgramScreen())),),
          GeneralSideBarTile(text: 'Exit', icon: Icons.exit_to_app, isActive: (widget.active == 'exit'),),
        ],
      ),
    );
  }
}

class GeneralSideBarTile extends StatelessWidget {

  GeneralSideBarTile({
    Key key,this.text, this.icon, this.isActive, this.onTap,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final bool isActive;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5.0, right: 20),
        decoration: BoxDecoration(
          color: (isActive) ? Colors.red :Colors.blueAccent,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
          boxShadow: [
            (isActive) ? BoxShadow(
              color: Colors.red,
              blurRadius: 1.0, // has the effect of softening the shadow
              spreadRadius: 1.0, // has the effect of extending the shadow
              offset: Offset(
                1.0, // horizontal, move right 10
                1.0, // vertical, move down 10
              ),
            ) : BoxShadow(
              color: Colors.blue,
              blurRadius: 1.0, // has the effect of softening the shadow
              spreadRadius: 1.0, // has the effect of extending the shadow
              offset: Offset(
                1.0, // horizontal, move right 10
                1.0, // vertical, move down 10
              ),
            )
          ],
        ),
        child: ListTile(
          title: Text(text, style: TextStyle(color: Colors.white),),
          leading: Icon(icon, color: Colors.white,),
        ),
      ),
    );
  }
}