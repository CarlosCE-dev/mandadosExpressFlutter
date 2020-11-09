import 'dart:convert';

// Enum
import 'package:mandado_express_dev/models/enums/messageStatus.dart';
import 'package:mandado_express_dev/models/enums/messageTypes.dart';

class Message {
    Message({
        this.id,
        this.body,
        this.userid,
        this.createOn,
        this.type,
        this.status,
    });

    /// Id of message
    int id;
    /// Body of Message
    String body;
    /// Id of related User
    String userid;
    /// Date the Message was created
    DateTime createOn;
    /// Type of Message
    MessageTypes type = MessageTypes.Map;
    /// Status of Message
    MessageStatus status = MessageStatus.Sended;

    factory Message.fromJson(String str) => Message.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Message.fromMap(Map<String, dynamic> json) => Message(
        id: json["id"],
        body: json["body"],
        userid: json["userid"],
        createOn: DateTime.parse(json["createOn"])?? null,
        type: json["type"],
        status: json["Status"]
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "body": body,
        "userid": userid,
        "createOn": createOn.toIso8601String(),
        "type": type,
        "Status": status,
    };
}
