// To parse this JSON data, do
//
//     final googleProfile = googleProfileFromMap(jsonString);

import 'dart:convert';

class GoogleProfile {
    GoogleProfile({
        required this.name,
        required this.grantedScopes,
        required this.id,
        required this.verifiedEmail,
        required this.givenName,
        required this.locale,
        required this.familyName,
        required this.email,
        required this.picture,
    });

    String name;
    String grantedScopes;
    String id;
    bool verifiedEmail;
    String givenName;
    String locale;
    String familyName;
    String email;
    String picture;

    factory GoogleProfile.fromJson(String str) => GoogleProfile.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GoogleProfile.fromMap(Map<String, dynamic> json) => GoogleProfile(
        name: json["name"],
        grantedScopes: json["granted_scopes"],
        id: json["id"],
        verifiedEmail: json["verified_email"],
        givenName: json["given_name"],
        locale: json["locale"],
        familyName: json["family_name"],
        email: json["email"],
        picture: json["picture"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "granted_scopes": grantedScopes,
        "id": id,
        "verified_email": verifiedEmail,
        "given_name": givenName,
        "locale": locale,
        "family_name": familyName,
        "email": email,
        "picture": picture,
    };
}
