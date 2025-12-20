import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_model.dart';


class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.taskModel,
  });

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: ListTile(
          title: Text(taskModel.tile,style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 25),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(taskModel.description),
              Text('Date: ${taskModel.createdDate}'),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    child: Text(taskModel.status,style: TextStyle(color: Colors.white,fontSize: 17),),
                  ),
                  Spacer(),
                  IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
