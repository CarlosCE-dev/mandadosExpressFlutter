import 'dart:convert';

ChatViewModel chatViewModelFromJson(String str) => ChatViewModel.fromJson(json.decode(str));

String chatViewModelToJson(ChatViewModel data) => json.encode(data.toJson());

class ChatViewModel {
    ChatViewModel({
        this.id,
        this.name,
        this.userId,
        this.roomMessages,
    });

    int id;
    String name;
    String userId;
    List<RoomMessage> roomMessages;

    factory ChatViewModel.fromJson(Map<String, dynamic> json) => ChatViewModel(
        id: json["id"],
        name: json["name"],
        userId: json["userId"],
        roomMessages: List<RoomMessage>.from(json["roomMessages"].map((x) => RoomMessage.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "userId": userId,
        "roomMessages": List<dynamic>.from(roomMessages.map((x) => x.toJson())),
    };
}

class RoomMessage {
    RoomMessage({
        this.body,
        this.createOn,
        this.userId,
    });

    String body;
    DateTime createOn;
    String userId;

    factory RoomMessage.fromJson(Map<String, dynamic> json) => RoomMessage(
        body: json["body"],
        createOn: DateTime.parse(json["createOn"]),
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "body": body,
        "createOn": createOn.toIso8601String(),
        "userId": userId,
    };
}
