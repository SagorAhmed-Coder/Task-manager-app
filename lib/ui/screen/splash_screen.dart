import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/data/controller/auth_controller.dart';
import 'package:task_manager/ui/screen/sign_in_screen.dart';
import 'package:task_manager/ui/utils/asset_path.dart';
import 'package:task_manager/ui/utils/screen_background.dart';

import 'main_bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _moveNextScreen();
  }

  Future<void> _moveNextScreen()async{
    await Future.delayed(Duration(seconds: 2));
    bool alreadyLoggedIn =await  AuthController.isUserAlreadyLoggedIn();
    if(alreadyLoggedIn){
      await AuthController.getUserData();
      Navigator.pushReplacementNamed(context, MainBottomNavBar.name);
    }else{
      Navigator.pushReplacementNamed(context, SignInScreen.name);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: ScreenBackground(
         child: Center(
           child: SvgPicture.asset(AssetPath.logoSvg,width: 140,),
         ),
       ),
    );
  }
}


