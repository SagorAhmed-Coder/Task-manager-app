import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/controller/auth_controller.dart';
import 'package:task_manager/data/model/user_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screen/forgot_password_email_screen.dart';
import 'package:task_manager/ui/screen/main_bottom_nav_bar.dart';
import 'package:task_manager/ui/screen/sign_up_screen.dart';
import 'package:task_manager/ui/utils/screen_background.dart';
import 'package:task_manager/ui/utils/snacbar_message.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    bool _signInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child:Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 18,
                children: [
                  const SizedBox(height: 80,),
                  //get started with
                  Text('Get Started With',style: Theme.of(context).textTheme.titleLarge),
                  //email text field
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (value) {
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your email';
                      }
                      if(EmailValidator.validate(value!) == false){
                        return 'Enter a valid Email';
                      }
                      return null;
                    },
                  ),
                  //password text field
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                     hintText: 'Password',
                    ),
                    validator: (value) {
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your password';
                      }
                      if(value!.length < 6){
                        return 'password should be 6 character';
                      }
                      return null;
                    },
                  ),
                  //filled button
                  Visibility(
                    visible: _signInProgress == false,
                    replacement: Center(child: CircularProgressIndicator(),),
                    child: FilledButton(
                        onPressed: _onTapSignInButton,
                        child: Icon(Icons.stacked_bar_chart),
                    ),
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
      ),
    );
  }

  void _onTapSignInButton(){
    if(_formKey.currentState!.validate()){
     _signIn();
    }
  }
  void _onTapForgotPasswordButton(){
    Navigator.pushNamed(context, ForgotPasswordEmailScreen.name);
  }
  void _onTapSignUpButton(){
   Navigator.pushNamed(context, SignUpScreen.name);
  }

  //api call
 Future<void> _signIn() async {
   _signInProgress = true;
   setState(() {});
   //ready data
   Map<String,dynamic> requestBody ={
     "email": _emailController.text,
     "password":_passwordController.text,
   };
   NetworkResponse response = await NetworkCaller.postRequest(
     Urls.signIn,
     body: requestBody,
   );
   _signInProgress = false;
   setState(() {});
   if(response.isSuccess){
     UserModel userModel = UserModel.fromJson(response.body['data']);
     String accessToken = response.body['token'];
     await AuthController.saveUserData(accessToken, userModel);
      Navigator.pushReplacementNamed(context, MainBottomNavBar.name,);
   }else{
     SnacbarMessage(context, response.errorMessage);
   }
 }

}
