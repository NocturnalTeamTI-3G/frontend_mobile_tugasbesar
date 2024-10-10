import 'package:flutter/material.dart';

class FitplanPage extends StatefulWidget {
  const FitplanPage({ Key? key }) : super(key: key);

  @override
  _FitplanPageState createState() => _FitplanPageState();
}

class _FitplanPageState extends State<FitplanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Text('Fit Plan Page'),
      ),
    );
  }
}