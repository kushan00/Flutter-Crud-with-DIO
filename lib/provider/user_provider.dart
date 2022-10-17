import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:practice_2/data/model/response/api_response.dart';
import 'package:practice_2/data/repository/user_repo.dart';
import 'package:practice_2/model/response_model.dart';
import 'package:practice_2/model/user_model.dart';

class UserProvider with ChangeNotifier {
  final UserRepo userRepo;

  UserProvider({required this.userRepo});

  late List<UserDataModel> _userDetails;
  List<UserDataModel> get userDetailsList => _userDetails;


  Future<dynamic> registration(UserDataModel userDataModel) async {
    notifyListeners();
    dynamic apiResponse = await userRepo.registration(userDataModel);
    Map map = apiResponse.data;
    notifyListeners();
    return map;
  }

  
  Future<void> getUserDetailsList() async {
    var apiResponse = await userRepo.getUserDetails();
    //print(apiResponse.data["data"]);
      _userDetails = [];
      apiResponse.data["data"].forEach((user){
        //print(user);
        UserDataModel usermodel = UserDataModel.fromJson(user);
        _userDetails.add(usermodel);
      });
    notifyListeners();
  }


  
  Future<dynamic> updateData(UserDataModel userDataModel , String id) async {
    notifyListeners();
    dynamic apiResponse = await userRepo.updateUser(userDataModel,id);
     Map map = apiResponse.data;
    notifyListeners();
    return map;
  }

  Future<dynamic> deleteData(String id) async {
    notifyListeners();
    dynamic apiResponse = await userRepo.deleteUser(id);
     Map map = apiResponse.data;
    notifyListeners();
    return map;
  }

  
}