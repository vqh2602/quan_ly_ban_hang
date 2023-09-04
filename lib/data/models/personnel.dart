// ignore_for_file: public_member_api_docs, sort_constructors_first
class Personnel {
  String? name;
  String? cccd;
  String? gender;
  String? birthday;
  String? phone;
  String? address;
  List<String>? permission;
  String? password;
  String? department;
  bool? resetPassword;
  String? uId;
  String? avatar;
  String? id;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? permissions;
  String? collectionId;
  String? databaseId;

  Personnel(
      {this.name,
      this.cccd,
      this.gender,
      this.birthday,
      this.phone,
      this.address,
      this.permission,
      this.password,
      this.department,
      this.resetPassword,
      this.uId,
      this.avatar,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.permissions,
      this.collectionId,
      this.databaseId});

  Personnel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cccd = json['cccd'];
    gender = json['gender'];
    birthday = json['birthday'];
    phone = json['phone'];
    address = json['address'];
    if (json['permission'] != null) {
      permission = [];
      json['permission'].forEach((v) {
        permission!.add(v);
      });
    }
    password = json['password'];
    department = json['department'];
    resetPassword = json['resetPassword'];
    uId = json['uId'];
    avatar = json['avatar'];
    id = json['\$id'];
    createdAt = json['\$createdAt'];
    updatedAt = json['\$updatedAt'];
    if (json['\$permissions'] != null) {
      permissions = [];
      json['\$permissions'].forEach((v) {
        permissions!.add(v);
      });
    }
    collectionId = json['$collectionId'];
    databaseId = json['$databaseId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['cccd'] = cccd;
    data['gender'] = gender;
    data['birthday'] = birthday;
    data['phone'] = phone;
    data['address'] = address;
    if (permission != null) {
      data['permission'] = permission;
    }
    data['password'] = password;
    data['department'] = department;
    data['resetPassword'] = resetPassword;
    data['uId'] = uId;
    data['avatar'] = avatar;
    // data['\$id'] = id;
    // data['\$createdAt'] = createdAt;
    // data['\$updatedAt'] = updatedAt;
    // if (permissions != null) {
    //   data['\$permissions'] = permissions!.map((v) => v).toList();
    // }
    // data['\$collectionId'] = collectionId;
    // data['\$databaseId'] = databaseId;
    return data;
  }

  Personnel copyWith({
    String? name,
    String? cccd,
    String? gender,
    String? birthday,
    String? phone,
    String? address,
    List<String>? permission,
    String? password,
    String? department,
    bool? resetPassword,
    String? uId,
    String? avatar,
    String? id,
    String? createdAt,
    String? updatedAt,
    List<dynamic>? permissions,
    String? collectionId,
    String? databaseId,
  }) {
    return Personnel(
      name: name ?? this.name,
      cccd: cccd ?? this.cccd,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      permission: permission ?? this.permission,
      password: password ?? this.password,
      department: department ?? this.department,
      resetPassword: resetPassword ?? this.resetPassword,
      uId: uId ?? this.uId,
      avatar: avatar ?? this.avatar,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      permissions: permissions ?? this.permissions,
      collectionId: collectionId ?? this.collectionId,
      databaseId: databaseId ?? this.databaseId,
    );
  }
}
