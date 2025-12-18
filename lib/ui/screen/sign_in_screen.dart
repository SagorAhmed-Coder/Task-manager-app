import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/forgot_password_email_screen.dart';
import 'package:task_manager/ui/screen/sign_up_screen.dart';
import 'package:task_manager/ui/utils/screen_background.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child:Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 18,
              children: [
                const SizedBox(height: 80,),
                //get started with
                Text('Get Started With',style: Theme.of(context).textTheme.titleLarge),
                //email text field
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                //password text field
                TextField(
                  decoration: InputDecoration(
                   hintText: 'Password',
                  ),
                ),
                //filled button
                FilledButton(
                    onPressed: _onTapSignInButton,
                    child: Icon(Icons.stacked_bar_chart),
                ),
                //forgot button
                Center(
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: _onTapForgotPasswordButton,
                          child: Text('Forgot password?'),
                      ),
                      //do not have an account
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,letterSpacing: 2),
                          text: "Don't have an account? ",
                          children: [
                            TextSpan(
                              style: TextStyle(color: Colors.green),
                              text: 'Sing Up',
                              recognizer: TapGestureRecognizer()
                              ..onTap = _onTapSignUpButton,
                            ),
                          ]
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }

  void _onTapSignInButton(){

  }
  void _onTapForgotPasswordButton(){
    Navigator.pushNamed(context, ForgotPasswordEmailScreen.name);
  }
  void _onTapSignUpButton(){
   Navigator.pushNamed(context, SignUpScreen.name);
  }
}
