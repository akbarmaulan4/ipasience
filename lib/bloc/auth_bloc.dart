import 'package:flutter/cupertino.dart';
import 'package:materi_ipa/api/api.dart';
import 'package:materi_ipa/model/kelas/kelas_model.dart';
import 'package:materi_ipa/model/login_model.dart';
import 'package:materi_ipa/model/subject/subject_model.dart';
import 'package:materi_ipa/utils/local_data.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc{
  final _messageError = PublishSubject<String>();
  final _dataLogin= PublishSubject<LoginModel>();
  final _selectedClass = PublishSubject<KelasModel>();
  final _dataKelas = PublishSubject<List<KelasModel>>();
  final _subjects = PublishSubject<List<SubjectModel>>();
  final _subjectsDetail = PublishSubject<SubjectModel>();

  Stream<String> get messageError => _messageError.stream;
  Stream<LoginModel> get dataLogin => _dataLogin.stream;
  Stream<KelasModel> get selectedClass => _selectedClass.stream;
  Stream<List<KelasModel>> get dataKelas => _dataKelas.stream;
  Stream<List<SubjectModel>> get subjects => _subjects.stream;
  Stream<SubjectModel> get subjectsDetail => _subjectsDetail.stream;

  TextEditingController edtUserName = TextEditingController();
  TextEditingController edtPass = TextEditingController();

  KelasModel _selectedKelas = KelasModel();
  KelasModel get selectedKelas => _selectedKelas;

  setDefaultKelas(){
    _selectedKelas.id = 99;
    _selectedKelas.name = 'Pilih Kelas';
    getAllClass();
  }

  changeClass(KelasModel val){
    _selectedClass.sink.add(val);
    getSubjects(val.id.toString());
  }

  validation(){
    if(edtUserName.text == ''){
      _messageError.sink.add('Username tidak boleh kosong!');
    }else if(edtPass.text == ''){
      _messageError.sink.add('Password tidak boleh kosong!');
    }else{
      login();
    }
  }

  login(){
    API.login(edtUserName.text, edtPass.text, (result, error) {
      if(error != null){
        _messageError.sink.add(error['message']);
        return;
      }
      if(result != null){
        var json = result as Map<String, dynamic>;
        var data = LoginModel.fromJson(json['data']);
        if(data != null){
          _dataLogin.sink.add(data);
          LocalData.saveUser(data);
        }
      }
    });
  }

  getAllClass(){
    API.getAllClass((result, error) {
      if(error != null){
        _messageError.sink.add(error['message']);
        return;
      }
      if(result != null){
        var json = result as Map<String, dynamic>;
        List<KelasModel> dataKelas = [];
        var data = (json['data'] as List)?.map((e) => e == null ? null : KelasModel.fromJson(e as Map<String, dynamic>))?.toList();
        if(data != null){
          KelasModel model = KelasModel();
          model.id = 99;
          model.name = 'Pilih Kelas';
          dataKelas.add(model);
          changeClass(model);
          dataKelas.addAll(data as List<KelasModel>);
          _dataKelas.sink.add(dataKelas);
        }
      }
    });
  }

  getSubjects(String classId){
    API.getSubjects(classId, (result, error) {
      if(error   != null){
        _messageError.sink.add(error['message']);
        return;
      }
      if(result != null){
        var json = result as Map<String, dynamic>;
        var data = (json['data'] as List)?.map((e) => e == null ? null : SubjectModel.fromJson(e as Map<String, dynamic>))?.toList();
        if(data != null){
          _subjects.sink.add(data as List<SubjectModel>);
        }
      }
    });
  }

  String _baseUrl = '';
  String get baseUrl => _baseUrl;

  getDetailSubject(String subjectId){
    API.getDetailSubject(subjectId, (result, error) {
      if(error   != null){
        _messageError.sink.add(error['message']);
        return;
      }
      if(result != null){
        var json = result as Map<String, dynamic>;
         _baseUrl = json['base_url'];
        var data = SubjectModel.fromJson(json['data']);
        if(data != null){
          _subjectsDetail.sink.add(data as SubjectModel);
        }
      }
    });
  }
}