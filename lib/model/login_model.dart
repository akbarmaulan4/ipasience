import 'package:materi_ipa/model/login/item_login.dart';

part 'login_model.g.dart';
class LoginModel{
  LoginModel(){}
  bool active = false;
  ItemLogin data = ItemLogin();

  factory LoginModel.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}