import 'dart:convert';

// Models
import 'package:mandado_express_dev/models/user.dart';

class AuthResponse {
    AuthResponse({
        this.token,
        this.user,
    });

    String token;
    User user;

    factory AuthResponse.fromJson(String str) => AuthResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AuthResponse.fromMap(Map<String, dynamic> json) => AuthResponse(
        token: json["token"],
        user: User.fromMap(json["user"]),
    );

    Map<String, dynamic> toMap() => {
        "token": token,
        "user": user.toMap(),
    };
}