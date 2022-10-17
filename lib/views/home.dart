import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:practice_2/data/dio_clinet.dart';
import 'package:practice_2/model/user_model.dart';
import 'package:practice_2/provider/user_provider.dart';
import 'package:practice_2/services/user_services.dart';
import 'package:practice_2/utils/app_constants.dart';
import 'package:practice_2/views/user_item.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false).getUserDetailsList();

     return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          elevation: 0,
        ),
        backgroundColor: Colors.grey[200],
        body: productForm(),
      ),
    );
  }

  Widget productForm(){
    return SingleChildScrollView(
      child : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Text("Add New User Click Here"),
          Text(""),
          Center(
            child: FormHelper.submitButton(
              "Add New User",
              (){
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/add',
                      (route) => false
                    );
                },
              btnColor:HexColor("#283B71"),
              borderColor:Colors.white,
              borderRadius:10,
              ),
          ),
          Consumer<UserProvider>(
            builder: (context, userProvider , child){
              List<UserDataModel> usersList;
              usersList = userProvider.userDetailsList;
              //print(usersList);
              return Column(
               children: [ 
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: usersList.length,
                      itemBuilder: (context, index) {
                        return UserItem(
                          model: usersList[index],
                          onDelete: (String id) {                          
                          userProvider.deleteData(id).then(
                            (response) {
                            if(response["message"] == "Success")
                            {                            
                              FormHelper.showSimpleAlertDialog(
                              context,
                              AppConstants.APP_NAME,
                              "Delete SuccessFul..!",                          
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
                              "Error occured , Delete Failed",                          
                              "OK", 
                              (){
                                Navigator.of(context).pop();
                              });
                            }   
                            },
                          );

                        },
                        );
                      },
                    ),
                ],
              );

            }
          ),
        ],
      ),
    );
  }
}
