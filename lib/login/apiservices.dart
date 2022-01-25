
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String? url = "https://cleaning.3m-erp.com/khadamaty/api/login";

    final response = await http.post(Uri.parse(url), body: requestModel.toJson());
    if (response.statusCode == 200 ) {
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception( 'Failed 2 load data!');
    }
  }
}

class LoginResponseModel {
  int? user;
  int? type;
  int? status;
  String? token;
  LoginResponseModel({this.user, this.type,this.status,this.token});
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      user: json["user"] ?? "",
      type: json["type"] ?? "",
      status: json["status"] ?? "",
      token: json["token"] ?? "",
    );
  }
}

class LoginRequestModel {
  String? phone;
  String? pass;

  LoginRequestModel({
    this.phone,
    this.pass,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'phone': phone,
      'password': pass,
    };

    return map;
  }
}