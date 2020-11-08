import 'package:flutter/material.dart';

// Lib
import 'package:http/http.dart' as http;

// Environments
import 'package:mandado_express_dev/global/environments.dart';

// Models
import 'package:mandado_express_dev/models/responses/roomResponse.dart';

class RoomService with ChangeNotifier {

  Future<List<RoomResponse>> getRooms(  ) async {

    final token = Enviroments.token;

    final resp = await http.get('${ Enviroments.apiUrl }/rooms', 
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token"
      }
    );

    if ( resp.statusCode == 200){
      final roomResponse = roomResponseFromJson( resp.body );
      return roomResponse;
    } else {
      return [];
    }

  }

  Future<bool> createRoom(  ) async {

    final token = Enviroments.token;

    final resp = await http.post('${ Enviroments.apiUrl }/rooms/create', 
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token"
      }
    );

    if ( resp.statusCode == 200){
      // final roomResponse = authResponseFromJson( resp.body );
      
      return true;
    } else {
      return false;
    }

  }
}