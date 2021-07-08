part of 'item_login.dart';
ItemLogin _$fromJson(Map<String, dynamic> json) {
  return ItemLogin()
    ..id = json['id']
    ..role_id = json['role_id']
    ..class_id = json['role_id']
    ..username = json['username']
    ..fullname = json['fullname']
    ..classname = json['classname']
    ..phone = json['phone']
    ..status = json['status']
    ..last_login_datetime = json['last_login_datetime']
    ..token = json['token']
  ;
}

Map<String, dynamic> _$toJson(ItemLogin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role_id': instance.role_id,
      'class_id': instance.class_id,
      'username': instance.username,
      'fullname': instance.fullname,
      'classname': instance.classname,
      'phone': instance.phone,
      'status': instance.status,
      'last_login_datetime': instance.last_login_datetime,
      'token': instance.token,
    };