List<UserDataModel> productsFromJson(dynamic str) =>
    List<UserDataModel>.from((str).map((x) => UserDataModel.fromJson(x)));



class UserDataModel {
  late String? id;
 late String? name;
 late String? mobileno;
 late String? email;
 late String? password;
 late String? userRole;

  UserDataModel(
      {
        this.id,
        this.name,
        this.mobileno,
        this.email,
        this.password,
        this.userRole,
      }
  );

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json['name'];
    mobileno = json['mobileno'];
    email = json['email'];
    password = json['password'];
    userRole = json['userRole'];

  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["_id"] = id;
    data['name'] = this.name;
    data['mobileno'] = this.mobileno;
    data['email'] = this.email;
    data['password'] = this.password;
    data['userRole'] = this.userRole;

    return data;
  }

}
