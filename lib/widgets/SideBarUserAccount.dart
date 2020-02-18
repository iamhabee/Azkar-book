import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SideBarUseraccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      // accountName: Text('The Academy', style: TextStyle(color: Colors.blue[900]),),
      // accountEmail: Text('kabirtoyyib19@gmail.com', style: TextStyle(color: Colors.blue[900]),),
      // currentAccountPicture: CircleAvatar(
      //   // backgroundImage: Image.asset('assets/images/logo.png'),
      //   backgroundImage: AssetImage('assets/images/logo.png'),
      // ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/logo.png'),
        )
      ),
    );
  }
}