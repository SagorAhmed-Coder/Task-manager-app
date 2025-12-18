import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/utils/my_app_bar.dart';
import 'package:task_manager/ui/utils/screen_background.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  static const String name = '/update-profile';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        fromUpdateProfile: true,
      ),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 18,
            children: [
              const SizedBox(height: 60,),
              Text(
                'Update Profile',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8)),
                      ),
                      child: Center(child: Text('Photos',style: TextStyle(color: Colors.white),),),
                    ),
                    const SizedBox(width: 10,),
                    Text('select photos',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400),)
                  ],
                ),
              ),
              TextField(decoration: InputDecoration(hintText: 'Email')),
              TextField(decoration: InputDecoration(hintText: 'First name')),
              TextField(decoration: InputDecoration(hintText: 'Last name')),
              TextField(decoration: InputDecoration(hintText: 'Mobile')),
              TextField(decoration: InputDecoration(hintText: 'Password')),
              FilledButton(
                  onPressed: _onTapUpdateButton,
                  child: Text('update Profile')),
              const SizedBox(height: 16,),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapUpdateButton(){

  }

}
