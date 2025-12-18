import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/utils/screen_background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 18,
            children: [
              const SizedBox(height: 60,),
              Text(
                'Join With Us',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextField(decoration: InputDecoration(hintText: 'Email')),
              TextField(decoration: InputDecoration(hintText: 'First name')),
              TextField(decoration: InputDecoration(hintText: 'Last name')),
              TextField(decoration: InputDecoration(hintText: 'Mobile')),
              TextField(decoration: InputDecoration(hintText: 'Password')),
              FilledButton(
                  onPressed: _onTapSignUpButton,
                  child: Text('Sign up')),
              const SizedBox(height: 16,),
              Center(
                child: RichText(
                    text:TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing:3,
                      ),
                      text: 'Already have an account? ',
                      children: [
                        TextSpan(
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                          text: 'Sign In',
                          recognizer: TapGestureRecognizer()
                            ..onTap = _onTapSingInButton,
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

  void _onTapSignUpButton(){

  }

  void _onTapSingInButton(){
    Navigator.pop(context);
   }
}
