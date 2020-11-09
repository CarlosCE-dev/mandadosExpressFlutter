import 'dart:convert';

DefaultResponse defaultResponseFromJson(String str) => DefaultResponse.fromJson(json.decode(str));

String defaultResponseToJson(DefaultResponse data) => json.encode(data.toJson());

class DefaultResponse {
    DefaultResponse({
        this.status,
        this.message,
    });

    String status;
    String message;

    factory DefaultResponse.fromJson(Map<String, dynamic> json) => DefaultResponse(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
