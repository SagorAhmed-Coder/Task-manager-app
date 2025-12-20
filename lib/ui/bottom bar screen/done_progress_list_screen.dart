import 'package:flutter/material.dart';

import '../utils/task_card.dart';

class DoneProgressListScreen extends StatefulWidget {
  const DoneProgressListScreen({super.key});

  @override
  State<DoneProgressListScreen> createState() => _DoneProgressListScreenState();
}

class _DoneProgressListScreenState extends State<DoneProgressListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (context, index) {
           // return TaskCard();
          },
        )
    );
  }
}
