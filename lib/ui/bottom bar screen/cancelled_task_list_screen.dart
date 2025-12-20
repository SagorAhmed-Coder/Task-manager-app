import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/utils/snacbar_message.dart';
import '../utils/task_card.dart';


class CancelTaskListScreen extends StatefulWidget {
  const CancelTaskListScreen({super.key});

  @override
  State<CancelTaskListScreen> createState() => _CancelTaskListScreenState();
}

class _CancelTaskListScreenState extends State<CancelTaskListScreen> {

  bool _cancelTaskInProgress = false;

  List<TaskModel> _cancelTask = [];

  @override
  void initState() {
    super.initState();
    _getCancelTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Visibility(
          visible: _cancelTaskInProgress == false,
          replacement: SizedBox(
            height: 500,
            child: Center(child: CircularProgressIndicator(),),
          ),
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: _cancelTask.length,
            itemBuilder: (context, index) {
              return TaskCard(
                taskModel: _cancelTask[index],
                reFreshList: () {
                  _getCancelTask();
                },
              );
            },
          ),
        )
    );
  }

  Future<void> _getCancelTask()async{
    _cancelTaskInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(Urls.cancelTask);
    _cancelTaskInProgress = false;
    setState(() {});
    if(response.isSuccess){
      List<TaskModel> list = [];
      for(Map<String,dynamic> jsonData in response.body['data']){
        list.add(TaskModel.formJson(jsonData));
      }
      _cancelTask = list;
    }else{
      SnacbarMessage(context, 'Failed to load progress task try again ');
    }
  }
}
