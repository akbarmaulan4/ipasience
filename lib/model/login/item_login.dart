part 'item_login.g.dart';
class ItemLogin{
  ItemLogin(){}
  int id = -1;
  String role_id = '';
  String class_id = '';
  String username = '';
  String fullname = '';
  String classname = '';
  String phone = '';
  String status = '';
  String last_login_datetime = '';
  String token = '';

  factory ItemLogin.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}