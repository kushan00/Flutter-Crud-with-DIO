
import "package:practice_2/data/dio_clinet.dart";
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:practice_2/data/dio_clinet.dart';
import 'package:practice_2/model/user_model.dart';
import 'package:practice_2/utils/app_constants.dart';

class UserServices {

  final DioClient dioClient;

  UserServices({required this.dioClient});

  Future<dynamic> CreateUser (
    UserDataModel model,
  ) async {
     print(model.toJson());
     print("model.toJson()");
     Response response = await dioClient.post(AppConstants.CREATE_USER_URL , data : model.toJson());
     print(response);
     return response;
  }

  Future<dynamic> GetUsers () async {
     Response response = await dioClient.get(AppConstants.GET_ALL_USERS_URL);
     return response;
  }

  Future<dynamic> GetUserByID (
    String id,
  ) async {
     Response response = await dioClient.get(AppConstants.GET_USER_BY_ID_URL + id);
     return response;
  }

  Future<dynamic> UpdateUser (
    UserDataModel model,
    String id,
  ) async {
     Response response = await dioClient.put(AppConstants.UPDTAE_USER_URL + id , data : model.toJson());
     return response;
  }

  Future<dynamic> DeleteUser (
    String id,
  ) async {
     Response response = await dioClient.delete(AppConstants.UPDTAE_USER_URL + id);
     return response;
  }

}