import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager/data/controller/auth_controller.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/utils/my_app_bar.dart';
import 'package:task_manager/ui/utils/screen_background.dart';
import 'package:task_manager/ui/utils/snacbar_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  static const String name = '/add-new-task';

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool addNewTaskInProgress = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Form(
            key: _globalKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                const SizedBox(height: 70,),
                Text('Add New Task',style: Theme.of(context).textTheme.titleLarge,),

                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'title',
                  ),
                  validator: (value) {
                    if(value?.trim().isEmpty ?? true){
                      return 'Enter your title';
                    }
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'description',
                  ),
                  validator: (value) {
                    if(value?.trim().isEmpty ?? true){
                      return 'Enter your description';
                    }
                  },
                ),
                const SizedBox(height: 20,),
                Visibility(
                  visible: addNewTaskInProgress == false,
                  replacement: Center(child: CircularProgressIndicator(),),
                  child: FilledButton(
                      onPressed: _onTapSubmitButton,
                      child: Text('Add Now')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _onTapSubmitButton(){
    if(_globalKey.currentState!.validate()){
      _addNewTask();
    }
  }
  //api call
  Future<void> _addNewTask()async{
    addNewTaskInProgress = true;
    setState(() {});
    //prepare data
    Map<String,dynamic> requestBody ={
      "title": _titleController.text,
      "description": _descriptionController.text,
      "status":"New"
    };
    NetworkResponse response = await NetworkCaller.postRequest(
     Urls.addNewTask,
      body: requestBody,
    );
    addNewTaskInProgress = false;
    setState(() {});
    if(response.isSuccess){
      clearTextField();
      SnacbarMessage(context, 'Add this task Successfully');
    }else{
      SnacbarMessage(context, response.errorMessage);
    }
  }

  //clear textfield
  void clearTextField(){
    _titleController.clear();
    _descriptionController.clear();
  }
  //dispose
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
