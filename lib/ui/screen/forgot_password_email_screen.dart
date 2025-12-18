import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/sign_in_screen.dart';
import 'package:task_manager/ui/utils/screen_background.dart';

import 'forgot_password_verify_opt_screen.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  static const String name = '/forgot-password-email-screen';

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              Text(
                'Your Email address',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'A 6 digit verification pin will send to \n your email address',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              TextField(decoration: InputDecoration(hintText: 'Email')),
              FilledButton(onPressed: _onTapCheckEmailButton, child: Text('Check email')),
              const SizedBox(height: 30,),
              Center(
                child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        letterSpacing: 3,
                        color: Colors.black,
                      ),
                      text: 'Have an account? ',
                      children: [
                        TextSpan(
                          style: TextStyle(
                            color: Colors.green,
                          ),
                          text: 'Sign In',
                          recognizer: TapGestureRecognizer()
                            ..onTap = _onTapSignInButton,
                        )
                      ]
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapCheckEmailButton(){
    Navigator.pushNamed(context, ForgotPasswordVerifyOptScreen.name);
  }

  void _onTapSignInButton(){
    Navigator.pushNamed(context, SignInScreen.name);
  }

}
