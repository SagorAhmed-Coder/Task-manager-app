import 'package:flutter/material.dart';
import 'package:task_manager/ui/bottom%20bar%20screen/cancelled_task_list_screen.dart';
import 'package:task_manager/ui/bottom%20bar%20screen/done_task_list_screen.dart';
import 'package:task_manager/ui/bottom%20bar%20screen/new_task_list_screen.dart';
import 'package:task_manager/ui/bottom%20bar%20screen/progress_task_list_screen.dart';

import '../utils/my_app_bar.dart';

class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({super.key});

  static const String name = '/main-bottom-nav-bar';

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {

  int _selectedIndex = 0;
  final List<Widget> _screens=[
    NewTaskListScreen(),
    ProgressTaskListScreen(),
    cancelTaskListScreen(),
    DoneTaskListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: MyAppBar(),
       body: _screens[_selectedIndex],
       bottomNavigationBar: NavigationBar(
         selectedIndex: _selectedIndex,
           onDestinationSelected: (index) {
             _selectedIndex = index;
             setState(() {});
           },
           destinations: [
             NavigationDestination(icon: Icon(Icons.new_label), label: 'New'),
             NavigationDestination(icon: Icon(Icons.access_time), label: 'progress'),
             NavigationDestination(icon: Icon(Icons.cancel), label: 'Cancel'),
             NavigationDestination(icon: Icon(Icons.done_all_outlined), label: 'Done'),
           ]
       )
    );
  }
}

