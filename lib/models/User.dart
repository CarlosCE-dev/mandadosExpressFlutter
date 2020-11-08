import 'dart:convert';

User usuarioFromJson(String str) => User.fromJson(json.decode(str));

String usuarioToJson(User data) => json.encode(data.toJson());

class User {
    User({
        this.id,
        this.email,
        this.firstName,
        this.lastName,
        this.password,
        this.fullName
    });

    String id;
    String firstName;
    String lastName;
    String email = "";
    String password = "";
    String fullName;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        fullName: json["fullName"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName" : firstName,
        "lastName" : lastName,
        "email" : email,
        "fullName" : fullName
    };
}
