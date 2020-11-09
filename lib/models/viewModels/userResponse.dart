import 'dart:convert';

List<UsersResponse> usersResponseFromJson(String str) => List<UsersResponse>.from(json.decode(str).map((x) => UsersResponse.fromJson(x)));

String usersResponseToJson(List<UsersResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersResponse {
    UsersResponse({
        this.userId,
        this.fullName,
    });

    String userId;
    String fullName;

    factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
        userId: json["userId"],
        fullName: json["fullName"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "fullName": fullName,
    };
}
