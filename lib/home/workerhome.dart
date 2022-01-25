import 'package:flutter/material.dart';

class WorkerHome extends StatelessWidget {
  const WorkerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Worker"),),
      body: Center(child:Text("Worker")),
    );
  }
}
