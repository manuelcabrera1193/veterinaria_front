// To parse this JSON data, do
//
//     final facebookProfile = facebookProfileFromMap(jsonString);

import 'dart:convert';

class FacebookProfile {
    FacebookProfile({
        required this.name,
        required this.lastName,
        required this.id,
        required this.firstName,
        required this.email,
        required this.picture,
    });

    String name;
    String lastName;
    String id;
    String firstName;
    String email;
    Picture picture;

    factory FacebookProfile.fromJson(String str) => FacebookProfile.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FacebookProfile.fromMap(Map<String, dynamic> json) => FacebookProfile(
        name: json["name"],
        lastName: json["last_name"],
        id: json["id"],
        firstName: json["first_name"],
        email: json["email"],
        picture: Picture.fromMap(json["picture"]),
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "last_name": lastName,
        "id": id,
        "first_name": firstName,
        "email": email,
        "picture": picture.toMap(),
    };
}

class Picture {
    Picture({
        required this.data,
    });

    Data data;

    factory Picture.fromJson(String str) => Picture.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Picture.fromMap(Map<String, dynamic> json) => Picture(
        data: Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "data": data.toMap(),
    };
}

class Data {
    Data({
        required this.isSilhouette,
        required this.width,
        required this.url,
        required this.height,
    });

    bool isSilhouette;
    int width;
    String url;
    int height;

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        isSilhouette: json["is_silhouette"],
        width: json["width"],
        url: json["url"],
        height: json["height"],
    );

    Map<String, dynamic> toMap() => {
        "is_silhouette": isSilhouette,
        "width": width,
        "url": url,
        "height": height,
    };
}
