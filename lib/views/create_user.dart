import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:practice_2/data/datasource/dio_user.dart';
import 'package:practice_2/data/dio_clinet.dart';
import 'package:practice_2/data/repository/user_repo.dart';
import 'package:practice_2/model/user_model.dart';
import 'package:practice_2/provider/user_provider.dart';
import 'package:practice_2/services/api_services.dart';
import 'package:practice_2/services/user_services.dart';
import 'package:practice_2/utils/app_constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';



class CreateUserAndEdit extends StatefulWidget {
  const CreateUserAndEdit({Key? key}) : super(key: key);

  @override
  State<CreateUserAndEdit> createState() => _CreateUserAndEditState();
}

class _CreateUserAndEditState extends State<CreateUserAndEdit> {

  UserDataModel? userModel;
  //UserServices userServices = UserServices();
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  bool isEditMode = false;
  //Dio dio = Dio();
  
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final mobileno = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final userRole = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    mobileno.dispose();
    email.dispose();
    password.dispose();
    userRole.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User Insert'),
          elevation: 0,
        ),
        backgroundColor: Colors.grey[200],
        body: Consumer<UserProvider>(
          builder:(context , userProvider , child) => SingleChildScrollView(
            child:Form(
                  key: _formKey,                  
                  child: Column(children: [
                    const Text(""),
                    TextFormField(
                      controller: name,
                      decoration: const InputDecoration(
                        hintText: "Name",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Name Here';
                        }
                        return null;
                      },
                    ),
                    const Text(""),
                    TextFormField(
                      controller: mobileno,
                      decoration: const InputDecoration(
                        hintText: "Mobile Number",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Mobile Number ';
                        }
                        return null;
                      },
                    ),
                    const Text(""),
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        hintText: "email",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email here';
                        }
                        return null;
                      },
                    ),
                    const Text(""),
                      TextFormField(
                      controller: password,
                      decoration: const InputDecoration(
                        hintText: "Password",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Password';
                        }
                        return null;
                      },
                    ),
                    const Text(""),
                      TextFormField(
                      controller: userRole,
                      decoration: const InputDecoration(
                        hintText: "User Role",  
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                        ),                     
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter User Role';
                        }
                        return null;
                      },
                    ),
                    const Text(""),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final _name = name.text;
                          final _mobileno = mobileno.text;
                          final _email = email.text;
                          final _password = email.text;
                          final _userRole = email.text;

                          UserDataModel userModel = UserDataModel(
                            name:_name,
                            mobileno: _mobileno,
                            email:_email,
                            password: _password,
                            userRole: _userRole
                          );
                          print(userModel);
                          userProvider.registration(userModel).then((response) async {
                            print(response);
                            if(response["message"] == "Success")
                            {  
                           
                              FormHelper.showSimpleAlertDialog(
                              context,
                              AppConstants.APP_NAME,
                              "Registration SuccessFul..!",                          
                              "OK", 
                              (){
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/',
                                  (route) => false
                                );
                              });                            
                            }
                            else
                            {
                              FormHelper.showSimpleAlertDialog(
                              context,
                              AppConstants.APP_NAME,
                              "Error occured , Registration Failed",                          
                              "OK", 
                              (){
                                Navigator.of(context).pop();
                              });
                            }
                           });
                          // do something with the form data
                        }
                      },
                      child: const Text('Submit'),
                    ),
                    const Text(""),
                    Center(
                      child: FormHelper.submitButton(
                        "Go Back",
                        (){
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/',
                                (route) => false
                              );
                          },
                        btnColor:HexColor("#283B71"),
                        borderColor:Colors.white,
                        borderRadius:10,
                        ),
                    ),
                  ]),
                ),
          ),
        ),
      ),
    );
  }
}