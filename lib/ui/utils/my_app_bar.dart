import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/controller/auth_controller.dart';
import 'package:task_manager/ui/screen/sign_in_screen.dart';
import 'package:task_manager/ui/screen/update_profile_screen.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
  const MyAppBar({
    super.key,
     this.fromUpdateProfile = false,
  });


  final bool fromUpdateProfile;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      leading: null,
     // automaticallyImplyLeading: false,
      actions: [
        IconButton(onPressed: () async {
         await AuthController.clearUserData();
         Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (route) => true,);
        }, icon: Icon(Icons.logout,color: Colors.white,)),
      ],
      title: GestureDetector(
        onTap: () {
          if(fromUpdateProfile){
            return;
          }
          Navigator.pushNamed(context, UpdateProfileScreen.name);
        },
        child: Row(
          spacing: 5,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://thumbs.dreamstime.com/b/young-indian-man-happy-outdoors-looking-camera-39595562.jpg'),
              backgroundColor: Colors.white,
              radius: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AuthController.user!.fullName,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white,fontSize: 20),),
                  Text(AuthController.user!.email,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
