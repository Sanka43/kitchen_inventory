import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: Center(
          child: Text("Welcome to Dashboard!", style: TextStyle(fontSize: 24))),
    );
  }
}
