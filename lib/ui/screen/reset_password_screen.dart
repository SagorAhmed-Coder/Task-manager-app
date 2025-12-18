import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/sign_in_screen.dart';
import 'package:task_manager/ui/utils/screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  static const String name = '/reset-password-screen';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
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
                Text('Set Password',style: Theme.of(context).textTheme.titleLarge),
                Text(
                  'Minimum length of password should be 8 character with letters and not giving to spacing',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                //email text field
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                //password text field
                TextField(
                  decoration: InputDecoration(
                   hintText: 'Confirm password',
                  ),
                ),
                //filled button
                FilledButton(
                    onPressed: _onTapResetButton,
                    child: Text('Reset'),
                ),
                //forgot button
                Center(
                  child: Column(
                    children: [
                      //do not have an account
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,letterSpacing: 2),
                          text: "Don't have an account? ",
                          children: [
                            TextSpan(
                              style: TextStyle(color: Colors.green),
                              text: 'Sing In',
                              recognizer: TapGestureRecognizer()
                              ..onTap = _onTapSignInButton,
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
    Navigator.pushNamed(context, SignInScreen.name);
  }
  void _onTapResetButton(){
  }

}
