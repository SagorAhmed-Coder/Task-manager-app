import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/utils/snacbar_message.dart';


class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskModel,
    required this.reFreshList,
  });

  final TaskModel taskModel;
  final VoidCallback reFreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {

  bool _changeStatusInProgress = false;
  bool _deleteTaskListInProgress = false;


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
          title: Text(widget.taskModel.tile,style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 25),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.taskModel.description),
              Text('Date: ${widget.taskModel.createdDate}'),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: _changeStatusColor(widget.taskModel.status),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    child: Text(widget.taskModel.status,style: TextStyle(color: Colors.white,fontSize: 17),),
                  ),
                  Spacer(),
                  Visibility(
                      visible: _deleteTaskListInProgress == false,
                      replacement: Center(child: CircularProgressIndicator(),),
                      child: IconButton(onPressed: _deleteTask, icon: Icon(Icons.delete))),
                  Visibility(
                      visible: _changeStatusInProgress == false,
                      replacement: Center(child: CircularProgressIndicator(),),
                      child: IconButton(onPressed: _showChangeStatusDialog, icon: Icon(Icons.edit))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showChangeStatusDialog(){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Change Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('New'),
              trailing: _checkStatus('New') ? Icon(Icons.done) : null,
              onTap: () {
                _onTapChangeStatus('New');
              },
            ),
            ListTile(
              title: Text('Progress'),
              trailing: _checkStatus('Progress') ? Icon(Icons.done) : null,
              onTap: () {
                _onTapChangeStatus('Progress');
              },
            ),
            ListTile(
              title: Text('Cancel'),
              trailing: _checkStatus('Cancel') ? Icon(Icons.done) : null,
              onTap: () {
                _onTapChangeStatus('Cancel');

              },
            ),
            ListTile(
              title: Text('Complete'),
              trailing: _checkStatus('Complete') ? Icon(Icons.done) : null,
              onTap: () {
                _onTapChangeStatus('Completed');
              },
            ),
          ],
        ),
      );
     },
    );
  }

  void _onTapChangeStatus(String status){
    if(_checkStatus(status)) return;
    Navigator.pop(context);
    _changeStatus(status);
  }

  bool _checkStatus(String status){
    return widget.taskModel.status == status;
  }

  Future<void> _changeStatus(String status)async {
     _changeStatusInProgress = true;
     setState(() {});
     final NetworkResponse response = await NetworkCaller.getRequest(Urls.changeStatus(
         widget.taskModel.id,
         status,
        ),
     );
     _changeStatusInProgress = true;
     setState(() {});
     if(response.isSuccess){
       widget.reFreshList();
     }else{
       SnacbarMessage(context, 'Failed to load change progress');
     }
  }

  Color _changeStatusColor(String status){
    switch(status){
      case 'New':
        return Colors.blue;
      case 'Progress':
        return Colors.yellow.shade700;
      case 'Cancelled':
        return Colors.red;
      case 'Completed':
        return Colors.green;
      default:
        return Colors.pink;
    }
  }
  
  Future<void> _deleteTask()async{
    _deleteTaskListInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(Urls.deleteTask(widget.taskModel.id));
    _deleteTaskListInProgress = false;
    setState(() {});
    if(response.isSuccess){
      widget.reFreshList();
    }else{
      SnacbarMessage(context, 'Delete not working,try again');
    }
  }
}
