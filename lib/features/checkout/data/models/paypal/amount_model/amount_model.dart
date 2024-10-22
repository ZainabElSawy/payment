class AmountModel {
  String? total;
  String? currency;
  Details? details;

  AmountModel(
      {required this.total, required this.currency, required this.details});

  AmountModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    currency = json['currency'];
    details = (json['details'] != null
        ? new Details.fromJson(json['details'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['currency'] = this.currency;
    if (this.details != null) {
      data['details'] = this.details?.toJson();
    }
    return data;
  }
}

class Details {
  String? subtotal;
  String? shipping;
  int? shippingDiscount;

  Details(
      {required this.subtotal,
      required this.shipping,
      required this.shippingDiscount});

  Details.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'];
    shipping = json['shipping'];
    shippingDiscount = json['shipping_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtotal'] = this.subtotal;
    data['shipping'] = this.shipping;
    data['shipping_discount'] = this.shippingDiscount;
    return data;
  }
}
