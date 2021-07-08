import 'dart:convert';
import 'dart:io';
import 'package:materi_ipa/model/login_model.dart';
import 'package:materi_ipa/utils/Utils.dart';
import 'package:materi_ipa/utils/local_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class API{
  //sb
  static String BASE_URL = "http://sapp.mustopha.id/api/v1";
  // static String BASE_URL = "http://api.kedaisayur.com/shipment-api/api/v1";
//  EnvironmentConfig.environment == Environment.development
//      ? "http://api-dev.kedai-sayur.com/kedaiemak-api/api/v1" //"""http://kei-dev.kedai-sayur.com:30517/kedaiemak-api/api/v1"
//      : EnvironmentConfig.environment == Environment.sandbox
//      ? "http://api-sandbox.kedai-sayur.com/kedaiemak-api/api/v1"//"http://api-sandbox.kedai-sayur.com/kedaiemak-api/api/v1"
//      : "http://api-ke.kedaisayur.com/kedaiemak-api/api/v1";

  static basePost(
      String module,
      Map<String, dynamic> post,
      Map<String, String> headers,
      bool encode,
      void callback(dynamic, Exception)) async {

    Utils.log("URL ${BASE_URL + module}");
    Utils.log("POST Header ${json.encode(headers)}");
    Utils.log("POST VALUE ${json.encode(post)}");
    String ada = json.encode(post);

    var mapError = new Map();
    try{
      final response = await http.post(Uri.parse(BASE_URL + module),
          // ignore: missing_return
          headers: headers, body: encode ? json.encode(post) : post).timeout(Duration(seconds: 30));
      var mapJson;
      if(response != null){
        int responseCode = response.statusCode;
        mapJson = json.decode(response.body);
        Utils.log("POST RESULT ${json.encode(mapJson)}");
        if (mapJson['code'] == 200) {
          callback(mapJson, null);
        } else if (responseCode == 401 ||
            responseCode == 403 ||
            mapJson['code'] == 401 ||
            mapJson['code'] == 403) {
          callback(null, mapJson);
        } else {
          callback(null, mapJson);
        }
      }else{
        mapError.putIfAbsent('message', () => 'Maaf, terjadi kesalahan koneksi, silahkan periksa jaringan anda dan coba beberapa saat lagi');
        callback(null, mapError);
      }
    } on SocketException catch(e){
      mapError.putIfAbsent('message', () => 'Maaf, terjadi kesalahan koneksi, silahkan periksa jaringan anda dan coba beberapa saat lagi');
      callback(null, mapError);
    } catch (e){
      mapError.putIfAbsent('message', () => 'Maaf, terjadi kesalahan koneksi, silahkan periksa jaringan anda dan coba beberapa saat lagi');
      callback(null, mapError);
    }
  }

  static login(String email, String pass, void callback(Map, Exception)) async{
    var header = new Map<String, String>();
    var post = new Map<String, dynamic>();
    header['Content-Type'] = 'application/json';
    post['phone'] = email;
    post['password'] = pass;
    basePost('/login', post, header, true, (result, error){
      callback(result, error);
    });
  }


  static basePost2(
      String url,
      Map<String, dynamic> post,
      Map<String, String> headers,
      bool encode,
      void callback(dynamic, Exception)) async {

    Utils.log("URL ${url}");
    Utils.log("POST Header ${json.encode(headers)}");
    Utils.log("POST VALUE ${json.encode(post)}");

    var mapError = new Map();
    try{

      final response = await http.post( Uri.parse(url),
          // ignore: missing_return
          headers: headers, body: encode ? json.encode(post) : post).timeout(Duration(seconds: 30),
      //     onTimeout: (){
      //   // callback(null, HTTPStatusFailedException('Koneksi terputus, silahkan coba lagi'));
      //   mapError.putIfAbsent('message', () => 'Koneksi terputus, silahkan coba lagi');
      //   callback(null, mapError);
      // }
      );
      if(response != null){
        int responseCode = response.statusCode;
        var mapJson = json.decode(response.body);
        Utils.log("POST RESULT ${json.encode(mapJson)}");
        if (mapJson['code'] == 200) {
          callback(mapJson, null);
        } else if (responseCode == 401 ||
            responseCode == 403 ||
            mapJson['code'] == 401 ||
            mapJson['code'] == 403) {
          callback(null, mapJson);
        } else {
          callback(null, mapJson);
        }
      }else{
        mapError.putIfAbsent('message', () => 'Maaf, terjadi kesalahan koneksi, silahkan periksa jaringan anda dan coba beberapa saat lagi');
        callback(null, mapError);
      }
    } on SocketException catch(e){
      mapError.putIfAbsent('message', () => 'Maaf, terjadi kesalahan koneksi, silahkan periksa jaringan anda dan coba beberapa saat lagi');
      callback(null, mapError);
    } catch (e){
      mapError.putIfAbsent('message', () => 'Maaf, terjadi kesalahan koneksi, silahkan periksa jaringan anda dan coba beberapa saat lagi');
      callback(null, mapError);
    }
  }

  static basePatch(
      String module,
      Map<String, dynamic> post,
      Map<String, String> headers,
      bool encode,
      void callback(dynamic, Exception)) async {

    Utils.log("URL ${BASE_URL + module}");
    Utils.log("POST Header ${json.encode(headers)}");
    Utils.log("POST VALUE ${json.encode(post)}");
    String ada = json.encode(post);

    var mapError = new Map();
    try{
      final response = await http.patch(Uri.parse(BASE_URL + module),
          // ignore: missing_return
          headers: headers, body: encode ? json.encode(post) : post).timeout(Duration(seconds: 30),
      //     onTimeout: (){
      //   // callback(null, HTTPStatusFailedException('Koneksi terputus, silahkan coba lagi'));
      //   mapError.putIfAbsent('message', () => 'Koneksi terputus, silahkan coba lagi');
      //   callback(null, mapError);
      // }
      );
      if(response != null){
        int responseCode = response.statusCode;
        var mapJson = json.decode(response.body);
        Utils.log("POST RESULT ${json.encode(mapJson)}");
        if (mapJson['code'] == 200) {
          callback(mapJson, null);
        } else if (responseCode == 401 ||
            responseCode == 403 ||
            mapJson['code'] == 401 ||
            mapJson['code'] == 403) {
          callback(null, mapJson);
        } else {
          callback(null, mapJson);
        }
      }else{
        mapError.putIfAbsent('message', () => 'Maaf, terjadi kesalahan koneksi, silahkan periksa jaringan anda dan coba beberapa saat lagi');
        callback(null, mapError);
      }
    } on SocketException catch(e){
      mapError.putIfAbsent('message', () => 'Maaf, terjadi kesalahan koneksi, silahkan periksa jaringan anda dan coba beberapa saat lagi');
      callback(null, mapError);
    } catch (e){
      mapError.putIfAbsent('message', () => 'Maaf, terjadi kesalahan koneksi, silahkan periksa jaringan anda dan coba beberapa saat lagi');
      callback(null, mapError);
    }
  }

  static baseGetFile(String module,
      Map<String, String> headers,
      String namaFile,
      void callback(File file)) async {
    Utils.log("URL ${BASE_URL + module}");
    try {
      final response = await http.get(Uri.parse(BASE_URL + module), headers: headers);
      if (response.contentLength == 0){
        return callback(File(''));
      }
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      File file = new File('$tempPath/$namaFile');
      await file.writeAsBytes(response.bodyBytes);
      callback(file);
    } catch (e) {
      // callback(null, HTTPStatusFailedException('Koneksi sedang tidak stabil'));
    }
  }

  static baseGet(String module, Map<String, String> headers,
      void callback(dynamic, exception)) async {
    Utils.log("URL ${BASE_URL + module}");

    Utils.log("POST HEADER ${json.encode(headers)}");
    // var connect = await isConnected();
    // if(!connect){
    //   callback(null, 'Tidak ada koneksi');
    //   return;
    // }

    var mapError = new Map();
    try {
      final response = await http.get(Uri.parse(BASE_URL + module), headers: headers);
      int responseCode = response.statusCode;
      var mapJson = json.decode(response.body);

      Utils.log("RESPONSE ${json.encode(mapJson)}");

      if (mapJson['code'] == 200) {
        callback(mapJson, null);
      } else if (responseCode == 401 ||
          responseCode == 403 ||
          mapJson['code'] == 401 ||
          mapJson['code'] == 403 || mapJson['code'] == 422) {
        callback(null, mapJson);
      } else {
        callback(null, mapJson);
      }
    } catch (e) {
      mapError.putIfAbsent('message', () => 'Maaf, terjadi kesalahan koneksi, silahkan periksa jaringan anda dan coba beberapa saat lagi');
      callback(null, mapError);
    }
  }

  static getAllClass(void callback(Map, Exception)) async{
    var header = new Map<String, String>();
    LoginModel user = await LocalData.getUser();
    header['Content-Type'] = 'application/json';
    header['token'] = '${user.data.token}';
    baseGet('/classes', header, (result, error) {
      callback(result, error);
    });
  }

  static getSubjects(String classid, void callback(Map, Exception)) async{
    var header = new Map<String, String>();
    LoginModel user = await LocalData.getUser();
    header['Content-Type'] = 'application/json';
    header['token'] = '${user.data.token}';
    baseGet('/subject/matter?class_id=${classid}', header, (result, error) {
      callback(result, error);
    });
  }

  static getDetailSubject(String id, void callback(Map, Exception)) async{
    var header = new Map<String, String>();
    LoginModel user = await LocalData.getUser();
    header['Content-Type'] = 'application/json';
    header['token'] = '${user.data.token}';
    baseGet('/subject/matter/${id}', header, (result, error) {
      callback(result, error);
    });
  }

  static Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  // static Future<bool> isConnected2() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   // if (connectivityResult == ConnectivityResult.none) {
  //   //   setState(() {
  //   //     isInternetOn = false;
  //   //   });
  //   // }
  //   return false;
  // }

  static baseDelete(String module, Map<String, String> headers,
      void callback(dynamic, exception)) async {
    Utils.log("URL ${BASE_URL + module}");
    Utils.log("Header ${json.encode(headers)}");
    var mapError = new Map();
    try {
      final response = await http.delete(Uri.parse(BASE_URL + module), headers: headers);
      int responseCode = response.statusCode;
      var mapJson = json.decode(response.body);

      Utils.log("RESPONSE ${mapJson.toString()}");

      if (mapJson['code'] == 200) {
        callback(mapJson, null);
      } else if (responseCode == 401 ||
          responseCode == 403 ||
          mapJson['code'] == 401 ||
          mapJson['code'] == 403 ||
          mapJson['code'] == 422) {
        mapError.putIfAbsent('message', () => 'Maaf, terjadi kesalahan koneksi, silahkan periksa jaringan anda dan coba beberapa saat lagi');
      } else {
        mapError.putIfAbsent('message', () => 'Maaf, terjadi kesalahan koneksi, silahkan periksa jaringan anda dan coba beberapa saat lagi');
      }
    } catch (e) {
      mapError.putIfAbsent('message', () => 'Maaf, terjadi kesalahan koneksi, silahkan periksa jaringan anda dan coba beberapa saat lagi');
    }
  }



  static basePut(
      String module,
      Map<String, dynamic> post,
      Map<String, String> headers,
      bool encode,
      void callback(dynamic, Exception)) async {

    Utils.log("URL ${BASE_URL + module}");
    Utils.log("POST Header ${json.encode(headers)}");
    Utils.log("POST VALUE ${json.encode(post)}");

    var mapError = new Map();
    try{
          final response = await http.put(Uri.parse(BASE_URL+module),
          // ignore: missing_return
          headers: headers, body: encode ? json.encode(post) : post).timeout(Duration(seconds: 30),
      //         onTimeout: (){
      //   // callback(null, HTTPStatusFailedException('Koneksi terputus, silahkan coba lagi'));
      //   mapError.putIfAbsent('message', () => 'Koneksi terputus, silahkan coba lagi');
      //   callback(null, mapError);
      // }
      );
      if(response != null){
        int responseCode = response.statusCode;
        var mapJson = json.decode(response.body);
        Utils.log("POST RESULT ${json.encode(mapJson)}");
        if (mapJson['code'] == 200) {
          callback(mapJson, null);
        } else if (responseCode == 401 ||
            responseCode == 403 ||
            mapJson['code'] == 401 ||
            mapJson['code'] == 403) {
          callback(null, mapJson);
        } else {
          callback(null, mapJson);
        }
      }else{
        mapError.putIfAbsent('message', () => 'Maaf, terjadi kesalahan koneksi, coba beberapa saat lagi');
        callback(null, mapError);
      }
    } on SocketException catch(e){
      mapError.putIfAbsent('message', () => 'Maaf, terjadi kesalahan koneksi, silahkan periksa jaringan anda dan coba beberapa saat lagi');
      callback(null, mapError);
    } catch (e){
      mapError.putIfAbsent('message', () => 'Maaf, terjadi kesalahan koneksi, silahkan periksa jaringan anda dan coba beberapa saat lagi');
      callback(null, mapError);
    }
  }
}