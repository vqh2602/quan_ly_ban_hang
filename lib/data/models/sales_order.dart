// ignore_for_file: public_member_api_docs, sort_constructors_first
class SalesOrder {
  String? uid;
  String? customerId;
  String? customerName;
  num? surcharge;
  num? discount;
  num? vat;
  String? timeOrder;
  String? deliveryTime;
  String? paymentTime;
  String? paymentStatus;
  String? deliveryStatus;
  num? partlyPaid;
  String? personnelSalespersonId;
  String? personnelSalespersonName;
  String? personnelShipperId;
  String? personnelShipperName;
  String? note;
  String? cancellationNotes;
  String? paymentsId; // id của phương thuc thanh toan
  num? totalMoney;
  num? profit;
  num? changeMoney;
  num? moneyGuests;
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
      this.changeMoney,
      this.moneyGuests,
      this.paymentsId,
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
    changeMoney = json['changeMoney'];
    moneyGuests = json['moneyGuests'];
    id = json['\$id'];
    paymentsId = json['paymentsId'];
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
    data['paymentsId'] = paymentsId;
    data['deliveryTime'] = deliveryTime;
    data['changeMoney'] = changeMoney;
    data['moneyGuests'] = moneyGuests;
    // data['\$id'] = id;
    // data['\$createdAt'] = createdAt;
    // data['\$updatedAt'] = updatedAt;
    // if (permissions != null) {
    //   data['\$permissions'] = permissions;
    // }
    // data['\$collectionId'] = collectionId;
    // data['\$databaseId'] = databaseId;
    return data;
  }

  SalesOrder copyWith({
    String? uid,
    String? customerId,
    String? customerName,
    num? surcharge,
    num? discount,
    num? vat,
    String? timeOrder,
    String? deliveryTime,
    String? paymentTime,
    String? paymentStatus,
    String? deliveryStatus,
    num? partlyPaid,
    String? personnelSalespersonId,
    String? personnelSalespersonName,
    String? personnelShipperId,
    String? personnelShipperName,
    String? note,
    String? cancellationNotes,
    num? totalMoney,
    num? profit,
    num? changeMoney,
    num? moneyGuests,
    String? paymentsId,
    String? id,
    String? createdAt,
    String? updatedAt,
    List<dynamic>? permissions,
    String? collectionId,
    String? databaseId,
  }) {
    return SalesOrder(
      uid: uid ?? this.uid,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      surcharge: surcharge ?? this.surcharge,
      discount: discount ?? this.discount,
      vat: vat ?? this.vat,
      timeOrder: timeOrder ?? this.timeOrder,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      paymentTime: paymentTime ?? this.paymentTime,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
      partlyPaid: partlyPaid ?? this.partlyPaid,
      personnelSalespersonId:
          personnelSalespersonId ?? this.personnelSalespersonId,
      personnelSalespersonName:
          personnelSalespersonName ?? this.personnelSalespersonName,
      personnelShipperId: personnelShipperId ?? this.personnelShipperId,
      personnelShipperName: personnelShipperName ?? this.personnelShipperName,
      note: note ?? this.note,
      cancellationNotes: cancellationNotes ?? this.cancellationNotes,
      totalMoney: totalMoney ?? this.totalMoney,
      profit: profit ?? this.profit,
      paymentsId: paymentsId ?? this.paymentsId,
      changeMoney: changeMoney ?? this.changeMoney,
      moneyGuests: moneyGuests ?? this.moneyGuests,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      permissions: permissions ?? this.permissions,
      collectionId: collectionId ?? this.collectionId,
      databaseId: databaseId ?? this.databaseId,
    );
  }
}
