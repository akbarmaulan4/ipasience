part 'subject_model.g.dart';
class SubjectModel{
  SubjectModel(){}
  int id = -1;
  String name = '';
  String notes = '';
  String contents = '';
  String sub_contents = '';
  String file_name = '';
  String subject_id = '';
  String type_id = '';
  String subject_name = '';
  String class_name = '';
  String status = '';

  factory SubjectModel.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}