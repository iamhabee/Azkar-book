import 'package:flutter/material.dart';

class SideBarUseraccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: Text('Abdulkabir Toyyib'),
      accountEmail: Text('kabirtoyyib19@gmail.com'),
      currentAccountPicture: CircleAvatar(
        child: Image.asset('assets/images/logo.png'),
        // backgroundImage: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}