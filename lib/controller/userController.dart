
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:toko_merchandise/database/user_helper.dart';
import 'package:toko_merchandise/models/user.dart';
import 'package:http/http.dart' as http;

class UserController {
  final dbHelper = UserDatabaseHelper.instance;

  Future<String> registerUser(User user) async{

    String message = "Registration Failed";

    int countUser = await dbHelper.countDataUser();

    user.id = countUser + 1;

    final userMap = {
      'id':user.id,
      'nama':user.nama,
      'email':user.email,
      'password':user.password
    };
    int rowAfected = await dbHelper.insertUser(userMap);

    if (rowAfected > 0) {
      message = "Registration Successful";
    }
    return message;
  }

  Future<String> loginUser(User user) async{
    String message = "Login Failed";
    final existingUser = await dbHelper.queryUserByEmail(user.email);

    if (existingUser !=null){
      if(existingUser['password'] == user.password){
        print("results: $existingUser");
        message = "Login Successful";
        final pref = await SharedPreferences.getInstance();
        await pref.setString("nama", existingUser['nama']);
        await pref.setString("email", existingUser['email']);
      } else {
        message = "Incorrect Password or Email";
      }
    }else{
      message = "User not found";
    }
    return message;
  }

  Future<String> loginWithApi(String email, String password) async{
    String message ="Login Failed";

    final response = await http.post(
      Uri.parse("http://10.202.0.119/api_toko_hmif/login.php"),
      body: {
        "email": email,
        "password": password
      }
    );

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['status'] == "success"){
        message = "Login Successful";
        final pref = await SharedPreferences.getInstance();
        await pref.setString("nama", json['data']['nama']);
        await pref.setString("email", json['data']['email']);
      }else{
        message = json['message'];
      }
    }

    return message;
  }

  Future<bool> checkSession() async{
    final pref = await SharedPreferences.getInstance();
    String? email = pref.getString("email");
    if(email != null && email.isNotEmpty){
      return true;
    }
    return false;
  }

  Future<void> logout() async{
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }



}