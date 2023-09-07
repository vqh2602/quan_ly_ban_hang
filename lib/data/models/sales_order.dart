class SalesOrder {
  String? uid;
  String? customerId;
  String? customerName;
  int? surcharge;
  int? discount;
  int? vat;
  String? timeOrder;
  String? deliveryTime;
  String? paymentTime;
  String? paymentStatus;
  String? deliveryStatus;
  int? partlyPaid;
  String? personnelSalespersonId;
  String? personnelSalespersonName;
  String? personnelShipperId;
  String? personnelShipperName;
  String? note;
  String? cancellationNotes;
  int? totalMoney;
  int? profit;
  String? id;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? permissions;
  String? collectionId;
  String? databaseId;

  SalesOrder(
      {this.uid,
      this.customerId,
      this.customerName,
      this.surcharge,
      this.discount,
      this.vat,
      this.timeOrder,
      this.deliveryTime,
      this.paymentTime,
      this.paymentStatus,
      this.deliveryStatus,
      this.partlyPaid,
      this.personnelSalespersonId,
      this.personnelSalespersonName,
      this.personnelShipperId,
      this.personnelShipperName,
      this.note,
      this.cancellationNotes,
      this.totalMoney,
      this.profit,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.permissions,
      this.collectionId,
      this.databaseId});

  SalesOrder.fromJson(Map<String, dynamic> json) {
    uid = json['id'];
    customerId = json['customerId'];
    customerName = json['customerName'];
    surcharge = json['surcharge'];
    discount = json['discount'];
    vat = json['vat'];
    timeOrder = json['timeOrder'];
    paymentStatus = json['paymentStatus'];
    deliveryStatus = json['deliveryStatus'];
    partlyPaid = json['partlyPaid'];
    deliveryTime = json['deliveryTime'];
    paymentTime = json['paymentTime'];
    personnelSalespersonId = json['personnelSalespersonId'];
    personnelSalespersonName = json['personnelSalespersonName'];
    personnelShipperId = json['personnelShipperId'];
    personnelShipperName = json['personnelShipperName'];
    note = json['note'];
    cancellationNotes = json['cancellationNotes'];
    totalMoney = json['totalMoney'];
    profit = json['profit'];
    id = json['\$id'];
    createdAt = json['\$createdAt'];
    updatedAt = json['\$updatedAt'];
    if (json['\$permissions'] != null) {
      permissions = <Null>[];
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
    data['customerId'] = customerId;
    data['customerName'] = customerName;
    data['surcharge'] = surcharge;
    data['discount'] = discount;
    data['vat'] = vat;
    data['timeOrder'] = timeOrder;
    data['paymentStatus'] = paymentStatus;
    data['deliveryStatus'] = deliveryStatus;
    data['partlyPaid'] = partlyPaid;
    data['personnelSalespersonId'] = personnelSalespersonId;
    data['personnelSalespersonName'] = personnelSalespersonName;
    data['personnelShipperId'] = personnelShipperId;
    data['personnelShipperName'] = personnelShipperName;
    data['note'] = note;
    data['cancellationNotes'] = cancellationNotes;
    data['totalMoney'] = totalMoney;
    data['profit'] = profit;
    data['paymentTime'] = paymentTime;
    data['deliveryTime'] = deliveryTime;
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
