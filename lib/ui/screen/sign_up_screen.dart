import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/utils/screen_background.dart';
import 'package:task_manager/ui/utils/snacbar_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _signUpInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 18,
              children: [
                const SizedBox(height: 60),
                Text(
                  'Join With Us',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: 'Email'),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your Email';
                    }
                    if (EmailValidator.validate(value!) == false) {
                      return 'Enter a valid Email address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(hintText: 'First name'),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your first name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(hintText: 'Last name'),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your last name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _mobileController,
                  decoration: InputDecoration(hintText: 'Mobile'),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your mobile name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(hintText: 'Password'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter a valid password';
                    }
                    if (value!.length < 6) {
                      return 'Your password should be 6 letters';
                    }
                    return null;
                  },
                ),
                Visibility(
                  visible: _signUpInProgress == false,
                  replacement: Center(child: CircularProgressIndicator(),),
                  child: FilledButton(
                    onPressed: _onTapSignUpButton,
                    child: Text('Sign up'),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black, letterSpacing: 3),
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
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignUpButton() {
    if (_formKey.currentState!.validate()) {
      _signUp();
    }
  }

  void _onTapSingInButton() {
    Navigator.pop(context);
  }

  //post request
  Future<void> _signUp() async {
    _signUpInProgress = true;
    setState(() {});
    //prepare data
    Map<String, dynamic> requestBody = {
      "email": _emailController.text.trim(),
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mobileController.text.trim(),
      "password": _passwordController.text,
    };

    //call api
    NetworkResponse response = await NetworkCaller.postRequest(
      Urls.registration,
      body: requestBody,
    );
    _signUpInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _clearTextField();
      SnacbarMessage(context, "Registration Successfully Done, Please sign In");
    } else {
      SnacbarMessage(context, response.errorMessage);
    }
  }

  //clear text field
  void _clearTextField(){
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _mobileController.clear();
    _passwordController.clear();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
