import 'package:flutter/material.dart';

import '../utils/task_card.dart';

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: 20,
        itemBuilder: (context, index) {
          return TaskCard();
        },
      )
    );
  }
}
