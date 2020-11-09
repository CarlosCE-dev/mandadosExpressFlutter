// To parse this JSON data, do
//
//     final room = roomFromMap(jsonString);

import 'dart:convert';

import 'package:mandado_express_dev/models/enums/roomStatus.dart';

class Room {
    Room({
        this.id,
        this.clientId,
        this.deliveryId,
        this.createOn,
        this.status,
        this.isActive,
    });

    /// Id of message
    int id;
    /// Id of customer related
    String clientId;
    /// Id of delivery
    String deliveryId;
    // Date of room created
    DateTime createOn;
    /// Status of Room
    RoomStatus status = RoomStatus.Progress;
    /// Define if message is active
    bool isActive = true;

    factory Room.fromJson(String str) => Room.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Room.fromMap(Map<String, dynamic> json) => Room(
        id: json["id"],
        clientId: json["clientId"],
        deliveryId: json["deliveryId"],
        createOn: DateTime.parse(json["createOn"]),
        status: json["status"],
        isActive: json["isActive"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "clientId": clientId,
        "deliveryId": deliveryId,
        "createOn": createOn.toIso8601String(),
        "status": status,
        "isActive": isActive,
    };
}
