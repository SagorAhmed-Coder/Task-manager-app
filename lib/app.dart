import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/forgot_password_email_screen.dart';
import 'package:task_manager/ui/screen/forgot_password_verify_opt_screen.dart';
import 'package:task_manager/ui/screen/main_bottom_nav_bar.dart';
import 'package:task_manager/ui/screen/reset_password_screen.dart';
import 'package:task_manager/ui/screen/sign_in_screen.dart';
import 'package:task_manager/ui/screen/sign_up_screen.dart';
import 'package:task_manager/ui/screen/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.green.shade200,
        inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style:FilledButton.styleFrom(
            fixedSize: Size.fromWidth(double.maxFinite),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Colors.green.shade600,
            foregroundColor: Colors.white,
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),
          labelMedium: TextStyle(color: Colors.grey,fontSize: 15),
        )
      ),
      initialRoute: SplashScreen.name,
      routes: <String,WidgetBuilder>{
        SplashScreen.name : (context) => SplashScreen(),
        SignInScreen.name : (context) => SignInScreen(),
        SignUpScreen.name : (context) => SignUpScreen(),
        ForgotPasswordEmailScreen.name : (context) => ForgotPasswordEmailScreen(),
        ForgotPasswordVerifyOptScreen.name : (context) => ForgotPasswordVerifyOptScreen(),
        ResetPasswordScreen.name : (context) => ResetPasswordScreen(),
        MainBottomNavBar.name : (context) => MainBottomNavBar(),
      },
    );
  }
}
