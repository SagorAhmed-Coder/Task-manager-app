import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/screen/reset_password_screen.dart';
import 'package:task_manager/ui/screen/sign_in_screen.dart';
import 'package:task_manager/ui/utils/screen_background.dart';

class ForgotPasswordVerifyOptScreen extends StatefulWidget {
  const ForgotPasswordVerifyOptScreen({super.key});

  static const String name = '/forgot-password-opt-screen';

  @override
  State<ForgotPasswordVerifyOptScreen> createState() =>
      _ForgotPasswordVerifyOptScreenState();
}

class _ForgotPasswordVerifyOptScreenState
    extends State<ForgotPasswordVerifyOptScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              Text(
                'OTP Verification',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'A 6 digit verification pin will send to \n your email address',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 20,),
              //otp
              PinCodeTextField(
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  activeColor: Colors.green,
                  disabledColor: Colors.white,
                  inactiveColor: Colors.white,
                  inactiveFillColor: Colors.white,
                ),
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.blue.shade50,
                enableActiveFill: true,
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                }, appContext: context,
              ),
              const SizedBox(height: 20,),
              //button
              FilledButton(onPressed: _onTapVerifyButton, child: Text('Verify')),
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

  void _onTapSignInButton(){
    Navigator.pushNamed(context, SignInScreen.name);
  }
  void _onTapVerifyButton(){
    Navigator.pushNamed(context, ResetPasswordScreen.name);
  }
}
