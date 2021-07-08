part of 'login_model.dart';
LoginModel _$fromJson(Map<String, dynamic> json) {
  return LoginModel()
    ..active = json['active']
    ..data = (json['data'] == null
        ? null
        : ItemLogin.fromJson(json['data'] as Map<String, dynamic>))
  ;
}

Map<String, dynamic> _$toJson(LoginModel instance) =>
    <String, dynamic>{
      'active': instance.active,
      'data': instance.data,
    };