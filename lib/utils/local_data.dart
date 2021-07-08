import 'dart:convert';
import 'package:materi_ipa/model/login_model.dart';
import 'package:materi_ipa/utils/text_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData{

  static Future<bool> removeAllPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  static void saveUser(LoginModel val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(TextConstant.user, json.encode(val.toJson()));
  }

  static Future<LoginModel> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(TextConstant.user);
    if (data != null && data.isNotEmpty) {
      return LoginModel.fromJson(json.decode(data));
    }
    return LoginModel();
  }

  static Future<bool> removeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(TextConstant.user);
  }
}