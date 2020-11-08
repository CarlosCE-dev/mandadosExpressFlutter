import 'dart:io';

class Enviroments {

  static String apiUrl = Platform.isAndroid ? 'http://192.168.0.16:8081/api' : 'http://localhost:5000/api';
  static String socketUrl = Platform.isAndroid ? 'http://192.168.0.16:8081' : 'http://localhost:3000';
}