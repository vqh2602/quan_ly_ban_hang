import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Permission {
  String? uid;
  String? name;
  String? note;
  String? code;
  List<String>? group;
  String? color;
  String? id;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? permissions;
  String? collectionId;
  String? databaseId;

  Permission(
      {this.uid,
      this.name,
      this.note,
      this.code,
      this.group,
      this.color,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.permissions,
      this.collectionId,
      this.databaseId});

  Permission.fromJson(Map<String, dynamic> json) {
    uid = json['id'];
    name = json['name'];
    note = json['note'];
    code = json['code'];
    group = json['group'].cast<String>();
    color = json['color'];
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
    data['group'] = group;
    data['color'] = color;
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

  Permission copyWith({
    String? uid,
    String? name,
    String? note,
    String? code,
    List<String>? group,
    String? color,
    String? id,
    String? createdAt,
    String? updatedAt,
    List<dynamic>? permissions,
    String? collectionId,
    String? databaseId,
  }) {
    return Permission(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      note: note ?? this.note,
      code: code ?? this.code,
      group: group ?? this.group,
      color: color ?? this.color,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      permissions: permissions ?? this.permissions,
      collectionId: collectionId ?? this.collectionId,
      databaseId: databaseId ?? this.databaseId,
    );
  }

  @override
  bool operator ==(covariant Permission other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.name == name &&
      other.note == note &&
      other.code == code &&
      listEquals(other.group, group) &&
      other.color == color &&
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
      group.hashCode ^
      color.hashCode ^
      id.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      permissions.hashCode ^
      collectionId.hashCode ^
      databaseId.hashCode;
  }
}
