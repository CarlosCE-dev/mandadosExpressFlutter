import 'dart:convert';

import 'package:flutter/material.dart';

// Lib
import 'package:http/http.dart' as http;

// Environments
import 'package:mandado_express_dev/global/environments.dart';

// Services
import 'package:mandado_express_dev/services/authService.dart';

// ViewModels
import 'package:mandado_express_dev/models/viewModels/chatViewModel.dart';
import 'package:mandado_express_dev/models/viewModels/roomResponse.dart';
import 'package:mandado_express_dev/models/viewModels/userResponse.dart';

class RoomService with ChangeNotifier {

  ChatViewModel chat;

  // Get rooms
  Future<List<RoomResponse>> getRooms(  ) async {

    final token = await AuthService.getToken();
    
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

  // Create new room
  Future<bool> getRoom( int roomId ) async {
    
    final token = await AuthService.getToken();
    
    final resp = await http.get('${ Enviroments.apiUrl }/rooms/$roomId', 
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token"
      }
    );

    if ( resp.statusCode == 200){
      final chatViewModel = chatViewModelFromJson(resp.body);
      this.chat = chatViewModel;
      
      return true;
    } else {
      return false;
    }

  }

  // Create new room
  Future<bool> createRoom( String deliveryId ) async {
    
    final token = await AuthService.getToken();
    final payload = {
      "deliveryId" : deliveryId
    };

    final resp = await http.post('${ Enviroments.apiUrl }/rooms/create', 
      body: jsonEncode(payload),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token"
      }
    );

    if ( resp.statusCode == 200){
      final chatViewModel = chatViewModelFromJson(resp.body);
      this.chat = chatViewModel;
      
      return true;
    } else {
      return false;
    }

  }

  // Get delivery users
  Future<List<UsersResponse>> getDeliveryUsers(  ) async {

    final token = await AuthService.getToken();

    final resp = await http.get('${ Enviroments.apiUrl }/rooms/create', 
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token"
      }
    );

    if ( resp.statusCode == 200){
      final roomResponse = usersResponseFromJson( resp.body );
      return roomResponse;
    } else {
      return [];
    }
  }


  addMessage( RoomMessage message ){
    this.chat.roomMessages.insert(0, message);
    notifyListeners();
  }
}