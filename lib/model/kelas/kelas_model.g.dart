part of 'kelas_model.dart';
KelasModel _$fromJson(Map<String, dynamic> json) {
  return KelasModel()
    ..id = json['id']
    ..name = json['name']
  ;
}

Map<String, dynamic> _$toJson(KelasModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };