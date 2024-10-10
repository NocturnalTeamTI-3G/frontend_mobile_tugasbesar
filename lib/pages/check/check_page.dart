import 'package:flutter/material.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({ Key? key }) : super(key: key);

  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Text('Check Page'),
      ),
    );
  }
}