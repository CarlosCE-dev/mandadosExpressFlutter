import 'dart:convert';

// Models
import 'package:mandado_express_dev/models/message.dart';

List<RoomResponse> roomResponseFromJson(String str) => List<RoomResponse>.from(json.decode(str).map((x) => RoomResponse.fromJson(x)));

String roomResponseToJson(List<RoomResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RoomResponse {
    RoomResponse({
        this.id,
        this.name,
        this.message,
    });

    int id;
    String name;
    Message message;

    factory RoomResponse.fromJson(Map<String, dynamic> json) => RoomResponse(
        id: json["id"],
        name: json["name"],
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "message": message == null ? null : message.toJson(),
    };
}

