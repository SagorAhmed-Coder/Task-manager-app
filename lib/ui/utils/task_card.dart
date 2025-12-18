import 'package:flutter/material.dart';


class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
  });

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
          title: Text('List of task',style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 25),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Description of the task'),
              Text('Date: 12 june 2022'),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    child: Text('New',style: TextStyle(color: Colors.white,fontSize: 17),),
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
