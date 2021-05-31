// To parse this JSON data, do
//
//     final userDetailsModel = userDetailsModelFromJson(jsonString);

import 'dart:convert';

UserDetailsModel userDetailsModelFromJson(String str) => UserDetailsModel.fromJson(json.decode(str));

String userDetailsModelToJson(UserDetailsModel data) => json.encode(data.toJson());

class UserDetailsModel {
    UserDetailsModel({
        this.status,
        this.d,
    });

    int status;
    D d;

    factory UserDetailsModel.fromJson(Map<String, dynamic> json) => UserDetailsModel(
        status: json["status"],
        d: D.fromJson(json["d"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "d": d.toJson(),
    };
}

class D {
    D({
        this.measurementId,
        this.neck,
        this.height,
        this.weight,
        this.belly,
        this.chest,
        this.wrist,
        this.armLength,
        this.thigh,
        this.shoulder,
        this.hips,
        this.ankle,
    });

    String measurementId;
    String neck;
    String height;
    String weight;
    String belly;
    String chest;
    String wrist;
    String armLength;
    String thigh;
    String shoulder;
    String hips;
    String ankle;

    factory D.fromJson(Map<String, dynamic> json) => D(
        measurementId: json["measurementId"],
        neck: json["neck"],
        height: json["height"],
        weight: json["weight"],
        belly: json["belly"],
        chest: json["chest"],
        wrist: json["wrist"],
        armLength: json["armLength"],
        thigh: json["thigh"],
        shoulder: json["shoulder"],
        hips: json["hips"],
        ankle: json["ankle"],
    );

    Map<String, dynamic> toJson() => {
        "measurementId": measurementId,
        "neck": neck,
        "height": height,
        "weight": weight,
        "belly": belly,
        "chest": chest,
        "wrist": wrist,
        "armLength": armLength,
        "thigh": thigh,
        "shoulder": shoulder,
        "hips": hips,
        "ankle": ankle,
    };
}
