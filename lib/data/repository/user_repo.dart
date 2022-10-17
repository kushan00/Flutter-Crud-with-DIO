import 'dart:io';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:practice_2/data/datasource/dio_user.dart';
import 'package:practice_2/data/model/response/api_response.dart';
import 'package:practice_2/model/user_model.dart';
import 'package:practice_2/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserRepo {
  final DioUser dioUser;
  final SharedPreferences sharedPreferences;

  UserRepo({required this.dioUser, required this.sharedPreferences});

  Future<dynamic> registration(UserDataModel userDataModel) async {
    try {
      print(userDataModel.toJson());
      Response response = await dioUser.post(
        AppConstants.CREATE_USER_URL,
        data: userDataModel.toJson(),
      );
      return response;
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> getUserDetails() async {
    try {
      final response = await dioUser.get(
        AppConstants.GET_ALL_USERS_URL
      );
      return response;
    } catch (e) {
      return e;
    }
  }

    Future<dynamic> updateUser(UserDataModel userDataModel , String id) async {
    try {
      //print("Indide the user_repo");
      //print(userDataModel.toJson());
      var url = AppConstants.UPDTAE_USER_URL + id;
      //print(url);
      Response response = await dioUser.put(
        url,
        data: userDataModel.toJson(),
      );
      return response;
    } catch (e) {
      return e;
    }
  }

    Future<dynamic> deleteUser(String id) async {
    try {
      //print("Indide the user_repo");
      //print(userDataModel.toJson());
      var url = AppConstants.DELETE_USER_URL + id;
      //print(url);
      Response response = await dioUser.delete(
        url,
      );
      return response;
    } catch (e) {
      return e;
    }
  }

}