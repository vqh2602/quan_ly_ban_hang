// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String? name;
  String? cccd;
  String? gender;
  String? birthday;
  String? phone;
  String? address;
  dynamic avatar;
  List<dynamic>? permission;
  String? password;
  String? department;
  dynamic resetPassword;
  String? uId;
  String? $id;
  String? $createdAt;
  String? $updatedAt;
  List<dynamic>? $permissions;
  String? $collectionId;
  String? $databaseId;

  User({
    this.name,
    this.cccd,
    this.gender,
    this.birthday,
    this.phone,
    this.address,
    this.avatar,
    this.permission,
    this.password,
    this.department,
    this.resetPassword,
    this.uId,
    this.$id,
    this.$createdAt,
    this.$updatedAt,
    this.$permissions,
    this.$collectionId,
    this.$databaseId,
  });

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    cccd = json['cccd'] as String?;
    gender = json['gender'] as String?;
    birthday = json['birthday'] as String?;
    phone = json['phone'] as String?;
    address = json['address'] as String?;
    avatar = json['avatar'];
    permission = json['permission'] as List?;
    password = json['password'] as String?;
    department = json['department'] as String?;
    resetPassword = json['resetPassword'];
    uId = json['uId'] as String?;
    $id = json['\$id'] as String?;
    $createdAt = json['\$createdAt'] as String?;
    $updatedAt = json['\$updatedAt'] as String?;
    $permissions = json['\$permissions'] as List?;
    $collectionId = json['\$collectionId'] as String?;
    $databaseId = json['\$databaseId'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['cccd'] = cccd;
    json['gender'] = gender;
    json['birthday'] = birthday;
    json['phone'] = phone;
    json['address'] = address;
    json['avatar'] = avatar;
    json['permission'] = permission;
    json['password'] = password;
    json['department'] = department;
    json['resetPassword'] = resetPassword;
    json['uId'] = uId;
    return json;
  }

  User copyWith({
    String? name,
    String? cccd,
    String? gender,
    String? birthday,
    String? phone,
    String? address,
    dynamic avatar,
    List<dynamic>? permission,
    String? password,
    String? department,
    dynamic resetPassword,
    String? uId,
  String? $id,
  String? $createdAt,
  String? $updatedAt,
  List<dynamic>? $permissions,
  String? $collectionId,
  String? $databaseId,
  }) {
    return User(
      name: name ?? this.name,
      cccd: cccd ?? this.cccd,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      avatar: avatar ?? this.avatar,
      permission: permission ?? this.permission,
      password: password ?? this.password,
      department: department ?? this.department,
      resetPassword: resetPassword ?? this.resetPassword,
      uId: uId ?? this.uId,
      $id: $id ?? this.$id,
      $createdAt: $createdAt ?? this.$createdAt,
     $updatedAt: $updatedAt ?? this.$updatedAt,
     $permissions: $permissions ?? this.$permissions,
     $collectionId: $collectionId ?? this.$collectionId,
      $databaseId: $databaseId ?? this.$databaseId,
    );
  }
}
