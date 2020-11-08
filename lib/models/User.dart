import 'dart:convert';

class User {
    User({
        this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.fullName,
        this.password,
    });

    String id;
    String firstName;
    String lastName;
    String email;
    String fullName;
    String password;

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        fullName: json["fullName"],
        password: json["password"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "fullName": fullName,
        "password": password,
    };
}
