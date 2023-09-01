class Category {
  String? uid;
  String? name;
  String? group;
  String? color;
  String? note;
  String? id;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? permissions;
  String? collectionId;
  String? databaseId;

  Category(
      {this.uid,
      this.name,
      this.group,
      this.color,
      this.note,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.permissions,
      this.collectionId,
      this.databaseId});

  Category.fromJson(Map<String, dynamic> json) {
    uid = json['id'];
    name = json['name'];
    group = json['group'];
    color = json['color'];
    note = json['note'];
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
    data['group'] = group;
    data['color'] = color;
    data['note'] = note;
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
}
