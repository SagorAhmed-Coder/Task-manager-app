import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/data/model/task_status_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screen/add_new_task_screen.dart';
import 'package:task_manager/ui/utils/snacbar_message.dart';
import '../utils/task_card.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  
  bool _newTaskListInProgress = false;
  bool _taskStatusCountInProgress = false;

  List<TaskModel> _newTaskList = [];
  List<TaskStatusModel> _taskStatusCount = [];



  @override
  void initState() {
     super.initState();
     _getNewTaskList();
     _getTaskStatusCount();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      floatingActionButton: FloatingActionButton(onPressed: goNewTaskListScreen,child: Icon(Icons.add),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTaskSummaryListView(),
            const SizedBox(height: 5,),
            Visibility(
              visible: _newTaskListInProgress == false,
              replacement: SizedBox(
                  height: 500,
                  child: Center(child: CircularProgressIndicator())),
                child: ListView.builder(
                  itemCount: _newTaskList.length,
                  primary: false,
                 shrinkWrap: true,
                 itemBuilder: (context, index) {
                return TaskCard(taskModel: _newTaskList[index],);
               },
              ),
            )
          ],
        ),
      )
    );
  }
  
  Future<void> _getNewTaskList()async{
    _newTaskListInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(Urls.newTaskList);
    _newTaskListInProgress = false;
    setState(() {});
    if(response.isSuccess){
      List<TaskModel> list = [];
      for(Map<String,dynamic> jsonData in response.body['data']){
         list.add(TaskModel.formJson(jsonData));
      }
       _newTaskList = list;
    }else{
      SnacbarMessage(context, 'Failed to load new task list');
    }
  }


  Future<void> _getTaskStatusCount()async{
    _taskStatusCountInProgress= true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(Urls.taskStatusCount);
    _taskStatusCountInProgress = false;
    setState(() {});
    if(response.isSuccess){
      List<TaskStatusModel> list = [];
      for(Map<String,dynamic> statusData in response.body['data']){
        list.add(TaskStatusModel.fromJson(statusData));
      }
      _taskStatusCount = list;
    }else{
      SnacbarMessage(context, 'Failed to load status count');
    }
  }


  void goNewTaskListScreen(){
    Navigator.pushNamed(context, AddNewTaskScreen.name);
  }


  Padding _buildTaskSummaryListView() {
    return Padding(
          padding: const EdgeInsets.only(left: 10,top: 10),
          child: SizedBox(
            height: 78,
            child: Visibility(
              visible: _taskStatusCountInProgress == false,
              replacement: Center(
                child: CircularProgressIndicator(),
              ),
              child: ListView.builder(
                itemCount: _taskStatusCount.length,
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
                          Text(_taskStatusCount[index].sum.toString(),style: Theme.of(context).textTheme.titleMedium,),
                          Text(_taskStatusCount[index].id,style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),),
                        ],
                      ),
                    ),
                  ),
                );
               },
              ),
            ),
          ),
        );
  }
  
  
}
