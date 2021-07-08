part of 'subject_model.dart';
SubjectModel _$fromJson(Map<String, dynamic> json) {
  return SubjectModel()
    ..id = json['id']
    ..name = json['name']
    ..notes = json['notes']
    ..contents = json['contents']
    ..sub_contents = json['sub_contents']
    ..file_name = json['file_name']
    ..subject_id = json['subject_id']
    ..type_id = json['type_id']
    ..subject_name = json['subject_name']
    ..class_name = json['class_name']
    ..status = json['status']
  ;
}

Map<String, dynamic> _$toJson(SubjectModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'notes': instance.notes,
      'contents': instance.contents,
      'sub_contents': instance.sub_contents,
      'file_name': instance.file_name,
      'subject_id': instance.subject_id,
      'type_id': instance.type_id,
      'subject_name': instance.subject_name,
      'class_name': instance.class_name,
      'status': instance.status,
    };