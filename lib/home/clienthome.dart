import 'package:flutter/material.dart';

class ClientHome extends StatelessWidget {
  const ClientHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Client"),),
      body: Center(
        child: Text("Client",style: TextStyle(fontSize: 24),)
      ),

    );
  }
}
