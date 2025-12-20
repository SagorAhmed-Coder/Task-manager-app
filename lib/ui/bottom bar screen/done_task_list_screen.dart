import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/utils/snacbar_message.dart';
import '../utils/task_card.dart';


class DoneTaskListScreen extends StatefulWidget {
  const DoneTaskListScreen({super.key});

  @override
  State<DoneTaskListScreen> createState() => _DoneTaskListScreenState();
}

class _DoneTaskListScreenState extends State<DoneTaskListScreen> {

  bool _doneTaskInProgress = false;

  List<TaskModel> _doneTask = [];

  @override
  void initState() {
    super.initState();
    _getDoneTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Visibility(
          visible: _doneTaskInProgress == false,
          replacement: SizedBox(
            height: 500,
            child: Center(child: CircularProgressIndicator(),),
          ),
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: _doneTask.length,
            itemBuilder: (context, index) {
              return TaskCard(
                taskModel: _doneTask[index],
                reFreshList: () {
                  _getDoneTask();
                },
              );
            },
          ),
        )
    );
  }

  Future<void> _getDoneTask()async{
    _doneTaskInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(Urls.doneTask);
    _doneTaskInProgress = false;
    setState(() {});
    if(response.isSuccess){
      List<TaskModel> list = [];
      for(Map<String,dynamic> jsonData in response.body['data']){
        list.add(TaskModel.formJson(jsonData));
      }
      _doneTask = list;
    }else{
      SnacbarMessage(context, 'Failed to load progress task try again ');
    }
  }
}
