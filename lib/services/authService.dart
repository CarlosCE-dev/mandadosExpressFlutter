import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// Lib
import 'package:flutter_secure_storage/flutter_secure_storage.dart' show FlutterSecureStorage;

// Environments
import 'package:mandado_express_dev/global/environments.dart';

// ViewModels
import 'package:mandado_express_dev/models/viewModels/authResponse.dart';

// Models
import 'package:mandado_express_dev/models/user.dart';

class AuthService with ChangeNotifier {

  User user = new User();
  bool _autenticando = false;

  final _storage = FlutterSecureStorage();

  Dio createDioInstance({ token = "" }){
    BaseOptions options = new BaseOptions(
      baseUrl: Enviroments.apiUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if ( token.isNotEmpty ) {
      options.headers['Authorization'] = "Bearer $token";
    }

    Dio dio = new Dio(options);
    return dio;
  }

  bool get autenticando => this._autenticando;
  set autenticando( bool valor ){
    this._autenticando = valor;
    notifyListeners();
  }

  // Getter del user de forma estatica
  String get getUserId => this.user.id;
  
  // Getter del token de forma estatica
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage(); 
    final token = await _storage.read(key: 'token');
    return token;
  }

  // Getter del token de forma estatica
  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage(); 
    await _storage.delete(key: 'token');
  }

  // Login
  Future<bool> login( String email, String password ) async {
    try {
      this.autenticando = true;

      final _dio = createDioInstance();

      final payload = {
        'email': email,
        'password': password
      };

      Response response = await _dio.post('/authenticate/login',
          data: jsonEncode(payload), 
      );

      this.autenticando = false;

      if ( response.statusCode == 200){

        AuthResponse loginResponse = AuthResponse.fromMap( response.data );
        this.user = loginResponse.user;

        await this._guardarToken(loginResponse.token);

        return true;
      } else {
        return false;
      }

    } catch (e) {
      // TODO: En caso de no poder logearse deberia notificar al usuario por X error
      this.autenticando = false;
      return false;
    }
  }

  // Register
  Future register( String firstName, String lastName, String email,  String password ) async {
    try {

      this.autenticando = true;

      final payload = {
        "firstName": firstName,
        "lastName" : lastName,
        "email" : email,
        "password" : password,
        "confirmPassword" : password
      };

      final _dio = createDioInstance();

      Response response = await _dio.post('/authenticate/register',
        data: jsonEncode(payload), 
      );

      this.autenticando = false;

      if ( response.statusCode == 200){

        final User user = new User(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password
        );

        this.user = user;
        
        return true;
      } else {

        // final respBody = jsonDecode(resp.body);
        return "Error";
      }

    } catch (e) {
      // TODO: En caso de no poder logearse deberia notificar al usuario por X error
      this.autenticando = false;
      return false;
    }
  }

  // Verify token
  Future<bool> isLoggedIn() async {
    try {

      final _dio = createDioInstance( token: await this._storage.read(key: 'token') );

      Response response = await _dio.get('/authenticate/refresh');

      if ( response.statusCode == 200){
        
        AuthResponse loginResponse = AuthResponse.fromMap( response.data );

        this.user = loginResponse.user;
        
        await this._guardarToken(loginResponse.token);

        return true;
      } else {
        this._eliminarToken();
        return false;
      }

    } catch (e) {
      // TODO: En caso de no poder logearse deberia notificar al usuario por X error
      return false;
    }
  }

  // Log out
  void logOut() async {
    await _eliminarToken();
    this.user = new User();
  }

  // Guardar token
  Future _guardarToken( String token ) async {
      return await _storage.write(key: 'token', value: token);
  }

  // Eliminar token
  Future _eliminarToken() async {
    await _storage.delete(key: 'token');
  }

}