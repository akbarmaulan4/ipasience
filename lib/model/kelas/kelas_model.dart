part 'kelas_model.g.dart';
class KelasModel{
  KelasModel(){}
  int id = -1;
  String name = '';

  factory KelasModel.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}