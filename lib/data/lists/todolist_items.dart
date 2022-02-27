// To parse this JSON data, do
//
//     final todoListItems = todoListItemsFromJson(jsonString);

import 'dart:convert';

TodoListItems todoListItemsFromJson(String str) => TodoListItems.fromJson(json.decode(str));

String todoListItemsToJson(TodoListItems data) => json.encode(data.toJson());

class TodoListItems {
  TodoListItems({
    this.id,
    this.name,
    this.description,
    this.count,
    this.todoListId,
  });

  int id;
  String name;
  String description;
  int count;
  int todoListId;

  factory TodoListItems.fromJson(Map<String, dynamic> json) => TodoListItems(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    count: json["count"],
    todoListId: json["todoListId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "count": count,
    "todoListId": todoListId,
  };
}
