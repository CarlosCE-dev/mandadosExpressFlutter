class Message {
    Message({
        this.body,
        this.userId,
        this.createdOn,
        this.status,
    });

    String body;
    String userId;
    String createdOn;
    int status;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        body: json["body"],
        userId: json["userId"],
        createdOn: json["createdOn"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "body": body,
        "userId": userId,
        "createdOn": createdOn,
        "status": status,
    };
}
