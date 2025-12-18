import 'package:flutter/material.dart';
import '../utils/task_card.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTaskSummaryListView(),
            const SizedBox(height: 5,),
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: 20,
              itemBuilder: (context, index) {
              return TaskCard();
             },
            )
          ],
        ),
      )
    );
  }




  Padding _buildTaskSummaryListView() {
    return Padding(
          padding: const EdgeInsets.only(left: 10,top: 10),
          child: SizedBox(
            height: 78,
            child: ListView.builder(
              itemCount: 20,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Card(
                  color: Colors.white,
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('43',style: Theme.of(context).textTheme.titleMedium,),
                        Text('New',style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),),
                      ],
                    ),
                  ),
                ),
              );
             },
            ),
          ),
        );
  }
}
