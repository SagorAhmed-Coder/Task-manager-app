import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/controller/auth_controller.dart';
import 'package:task_manager/data/model/user_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/utils/my_app_bar.dart';
import 'package:task_manager/ui/utils/screen_background.dart';
import 'package:task_manager/ui/utils/snacbar_message.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  static const String name = '/update-profile';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

   TextEditingController _emailController = TextEditingController();
   TextEditingController _firstNameController = TextEditingController();
   TextEditingController _lastNameController = TextEditingController();
   TextEditingController _mobileController = TextEditingController();
   TextEditingController _passwordController = TextEditingController();

   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   @override
  void initState() {
    super.initState();
    final UserModel userModel = AuthController.user!;
    _emailController.text = userModel.email;
    _firstNameController.text = userModel.firstName;
    _lastNameController.text = userModel.lastName;
    _mobileController.text = userModel.mobile;
   }

   final ImagePicker imagePicker = ImagePicker();
   XFile? pickedImage;
   bool _updateProfileInProgress = false;

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        fromUpdateProfile: true,
      ),
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
                const SizedBox(height: 60,),
                Text(
                  'Update Profile',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                GestureDetector(
                  onTap: _pickTheImage,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Container(
                            height: 50,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8)),
                            ),
                            child: Center(child: Text('Photos',style: TextStyle(color: Colors.white),),),
                          ),

                        const SizedBox(width: 10,),
                        Expanded(child: pickedImage == null ? Text('select photos',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400),) : Text(pickedImage!.path)),
                      ],
                    ),
                  ),
                ),
                TextFormField(
                    enabled: false,
                    controller: _emailController,
                    decoration: InputDecoration(hintText: 'Email'),
                    validator: (value) {
                      if(value!.trim().isEmpty){
                        return 'Enter your email';
                      }
                      if(EmailValidator.validate(value) == false){
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                ),
                TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(hintText: 'First name'),
                    validator: (value) {
                      if(value!.trim().isEmpty){
                        return 'Enter your first name';
                      }
                      return null;
                    },
                ),
                TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(hintText: 'Last name'),
                    validator: (value) {
                     if(value!.trim().isEmpty){
                      return 'Enter your last name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                    controller: _mobileController,
                    decoration: InputDecoration(hintText: 'Mobile'),
                  validator: (value) {
                    if(value!.trim().isEmpty){
                      return 'Enter your mobile number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(hintText: 'Password'),
                    validator: (value) {
                      String password = value!;
                      if(password.isEmpty && password.length < 6){
                        return 'At least 6 digit password require';
                      }
                      return null;
                    },
                ),
                Visibility(
                  visible: _updateProfileInProgress == false,
                  replacement: Center(child: CircularProgressIndicator(),),
                  child: FilledButton(
                      onPressed: _onTapUpdateButton,
                      child: Text('update Profile')),
                ),
                const SizedBox(height: 16,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapUpdateButton(){
     if(_formKey.currentState!.validate()){
       _updateProfile();
     }
  }

  Future<void> _pickTheImage() async {
     XFile? pickImage = await imagePicker.pickImage(source: ImageSource.gallery);
     if(pickImage != null){
       pickedImage = pickImage;
       setState(() {});
     }
  }

  Future<void> _updateProfile() async {
     _updateProfileInProgress = true;
     setState(() {});

     Map<String,dynamic> requestBody = {
       "email": _emailController.text,
       "firstName":_firstNameController.text.trim(),
       "lastName":_lastNameController.text.trim(),
       "mobile":_mobileController.text.trim(),
     };

     if(_passwordController.text.isNotEmpty){
       requestBody['password'] = _passwordController.text;
     }

     if(pickedImage != null){
       Uint8List imageBytes = await pickedImage!.readAsBytes();
       requestBody['photo'] = base64Encode(imageBytes);
     }
     final NetworkResponse response = await NetworkCaller.postRequest(Urls.updateTaskUrl,body: requestBody);

     if(response.isSuccess){
       requestBody['_id'] = AuthController.user!.id;
      await AuthController.saveUpdateUserData(UserModel.fromJson(requestBody));
       SnacbarMessage(context, 'Profile update Successfully');
     }else{
       SnacbarMessage(context, 'Failed to update your profile try again!');
     }
     _updateProfileInProgress = false;
     setState(() {});
  }



}
