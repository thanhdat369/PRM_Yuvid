import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  int id;
  Home({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("Home $id"),
      ),
    );
  }
}
