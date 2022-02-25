// To parse this JSON data, do
//
//     final todolist = todolistFromJson(jsonString);

import 'dart:convert';

Todolist todolistFromJson(String str) => Todolist.fromJson(json.decode(str));

String todolistToJson(Todolist data) => json.encode(data.toJson());

class Todolist {
  Todolist({
    this.id,
    this.name,
    this.deviceInfo,
  });

  int id;
  String name;
  String deviceInfo;

  factory Todolist.fromJson(Map<String, dynamic> json) => Todolist(
    id: json["id"],
    name: json["name"],
    deviceInfo: json["deviceInfo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "deviceInfo": deviceInfo,
  };
}
