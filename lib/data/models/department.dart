// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class Department {
  String? uid;
  String? name;
  String? note;
  String? code;
  String? id;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? permissions;
  String? collectionId;
  String? databaseId;

  Department(
      {this.uid,
      this.name,
      this.note,
      this.code,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.permissions,
      this.collectionId,
      this.databaseId});

  Department.fromJson(Map<String, dynamic> json) {
    uid = json['id'];
    name = json['name'];
    note = json['note'];
    code = json['code'];
    id = json['\$id'];
    createdAt = json['\$createdAt'];
    updatedAt = json['\$updatedAt'];
    if (json['\$permissions'] != null) {
      permissions = [];
      json['\$permissions'].forEach((v) {
        permissions!.add(v);
      });
    }
    collectionId = json['\$collectionId'];
    databaseId = json['\$databaseId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = uid;
    data['name'] = name;
    data['note'] = note;
    data['code'] = code;
    data['\$id'] = id;
    data['\$createdAt'] = createdAt;
    data['\$updatedAt'] = updatedAt;
    if (permissions != null) {
      data['\$permissions'] = permissions;
    }
    data['\$collectionId'] = collectionId;
    data['\$databaseId'] = databaseId;
    return data;
  }

  @override
  bool operator ==(covariant Department other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.name == name &&
      other.note == note &&
      other.code == code &&
      other.id == id &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt &&
      listEquals(other.permissions, permissions) &&
      other.collectionId == collectionId &&
      other.databaseId == databaseId;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      name.hashCode ^
      note.hashCode ^
      code.hashCode ^
      id.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      permissions.hashCode ^
      collectionId.hashCode ^
      databaseId.hashCode;
  }
}
