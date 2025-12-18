import 'package:flutter/material.dart';
import 'package:task_manager/ui/utils/my_app_bar.dart';
import 'package:task_manager/ui/utils/screen_background.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  static const String name = '/add-new-task';

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              const SizedBox(height: 70,),
              Text('Add New Task',style: Theme.of(context).textTheme.titleLarge,),

              TextField(
                decoration: InputDecoration(
                  hintText: 'title',
                ),
              ),
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'description',

                ),
              ),
              const SizedBox(height: 20,),
              FilledButton(onPressed: (){}, child: Text('Add Now')),
            ],
          ),
        ),
      )
    );
  }
}
