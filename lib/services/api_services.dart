import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart' as http;
import 'package:practice_2/model/user_model.dart';
import 'package:practice_2/utils/app_constants.dart';



class APIService {
  static var client = http.Client();

  static Future<List<UserDataModel>?> getProducts() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      AppConstants.BASE_URL,
      AppConstants.GET_ALL_USERS_URL,
    );

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return productsFromJson(data["data"]);

      //return true;
    } else {
      return null;
    }
  }

  static Future<bool> saveProduct(
    UserDataModel model
  ) async {

    var url = Uri.http(AppConstants.BASE_URL, AppConstants.CREATE_USER_URL);

    var requestMethod =  "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["name"] = model.name!;
    request.fields["mobileno"] = model.mobileno!;
    request.fields["email"] = model.email!;
    request.fields["password"] = model.password!;
    request.fields["userRole"] = model.userRole!;

    print(request);
    print(request.fields);

    var response = await request.send();
     print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // static Future<bool> deleteProduct(productId) async {
  //   Map<String, String> requestHeaders = {
  //     'Content-Type': 'application/json',
  //   };
    
  //   var url = Uri.http(
  //     Config.apiURL,
  //     Config.productsAPI + "/" + productId,
  //   );

  //   var response = await client.delete(
  //     url,
  //     headers: requestHeaders,
  //   );

  //   if (response.statusCode == 200) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
