import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/utils/snacbar_message.dart';
import '../utils/task_card.dart';

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
  
  bool _progressTaskInProgress = false;

  List<TaskModel> _progressTask = [];

  @override
  void initState() {
    super.initState();
    _getProgressTask();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Visibility(
        visible: _progressTaskInProgress == false,
        replacement: SizedBox(
          height: 500,
          child: Center(child: CircularProgressIndicator(),),
        ),
        child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: _progressTask.length,
          itemBuilder: (context, index) {
            return TaskCard(
              taskModel: _progressTask[index],
              reFreshList: () {
                _getProgressTask();
              },
            );
          },
        ),
      )
    );
  }
  
  Future<void> _getProgressTask()async{
    _progressTaskInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(Urls.progressTask);
    _progressTaskInProgress = false;
    setState(() {});
    if(response.isSuccess){
      List<TaskModel> list = [];
      for(Map<String,dynamic> jsonData in response.body['data']){
        list.add(TaskModel.formJson(jsonData));
      }
      _progressTask = list;
    }else{
       SnacbarMessage(context, 'Failed to load progress task try again ');
    }
  }
}
