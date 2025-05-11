import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text("Add new note"),
      ),
      appBar: AppBar(title: Text("Appbar")),
      body: Column(children: [Text("Home")]),
    );
  }
}
