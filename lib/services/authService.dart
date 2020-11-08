import 'dart:convert';
import 'package:flutter/material.dart';

// Lib
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Environments
import 'package:mandado_express_dev/global/environments.dart';

// Models
import 'package:mandado_express_dev/models/user.dart';
import 'package:mandado_express_dev/models/responses/authResponse.dart';

class AuthService with ChangeNotifier {

  User user = new User();
  bool _autenticando = false;

  final _storage = FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando( bool valor ){
    this._autenticando = valor;
    notifyListeners();
  }

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

  Future<bool> login( String email, String password ) async {

    this.autenticando = true;

    final payload = {
      'email': email,
      'password': password
    };

    final resp = await http.post('${ Enviroments.apiUrl }/authenticate/login', 
      body: jsonEncode(payload),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    this.autenticando = false;
    if ( resp.statusCode == 200){
      final loginResponse = authResponseFromJson( resp.body );
      this.user = loginResponse.user;
      
      await this._guardarToken(loginResponse.token);

      return true;
    } else {
      return false;
    }

  }

  Future register( String firstName, String lastName, String email,  String password ) async {
    this.autenticando = true;

    final payload = {
      "firstName": firstName,
      "lastName" : lastName,
      "email" : email,
      "password" : password,
      "confirmPassword" : password
    };

    final resp = await http.post('${ Enviroments.apiUrl }/authenticate/register', 
      body: jsonEncode(payload),
      headers: {
        'Content-Type': 'application/json'
      },
    );

    this.autenticando = false;

    if ( resp.statusCode == 200){

      final User user = new User(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password
      );

      this.user = user;
      
      return true;
    } else {

      final loginResponse = authResponseFromJson( resp.body );
      this.user = loginResponse.user;
      // final respBody = jsonDecode(resp.body);
      return "Error";
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');
    
    final resp = await http.get('${ Enviroments.apiUrl }/authenticate/refresh', 
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token"
      }
    );

    if ( resp.statusCode == 200){
      final loginResponse = authResponseFromJson( resp.body );
      this.user = loginResponse.user;
      
      await this._guardarToken(loginResponse.token);

      return true;
    } else {
      this._eliminarToken();
      return false;
    }
  }

  Future _guardarToken( String token ) async {
      return await _storage.write(key: 'token', value: token);
  }

  Future _eliminarToken() async {
    await _storage.delete(key: 'token');
  }

}