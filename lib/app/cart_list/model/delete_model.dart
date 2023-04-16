// To parse this JSON data, do
//
//     final cartDelete = cartDeleteFromJson(jsonString);

import 'dart:convert';

CartDelete cartDeleteFromJson(String str) => CartDelete.fromJson(json.decode(str));

String cartDeleteToJson(CartDelete data) => json.encode(data.toJson());



class CartDelete {
  bool? status;
  String? message;

  CartDelete({this.status, this.message});

  CartDelete.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
