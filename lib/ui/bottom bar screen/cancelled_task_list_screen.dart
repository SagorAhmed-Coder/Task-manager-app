import 'package:flutter/material.dart';

import '../utils/task_card.dart';

class CancelledTaskListScreen extends StatefulWidget {
  const CancelledTaskListScreen({super.key});

  @override
  State<CancelledTaskListScreen> createState() => _CancelledTaskListScreenState();
}

class _CancelledTaskListScreenState extends State<CancelledTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (context, index) {
            //return TaskCard();
          },
        )
    );
  }
}
