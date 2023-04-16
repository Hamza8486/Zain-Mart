
// To parse this JSON data, do
//
//     final updateCartModel = updateCartModelFromJson(jsonString);

import 'dart:convert';

UpdateCartModel updateCartModelFromJson(String str) => UpdateCartModel.fromJson(json.decode(str));

String updateCartModelToJson(UpdateCartModel data) => json.encode(data.toJson());


class UpdateCartModel {
  bool? status;
  Data? data;
  String? message;

  UpdateCartModel({this.status, this.data, this.message});

  UpdateCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? userId;
  String? productId;
  int? quantity;
  String? amount;
  String? discount;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.userId,
        this.productId,
        this.quantity,
        this.amount,
        this.discount,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    amount = json['amount'];
    discount = json['discount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['amount'] = this.amount;
    data['discount'] = this.discount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
