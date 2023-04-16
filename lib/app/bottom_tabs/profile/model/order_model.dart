// To parse this JSON data, do
//
//     final allOrderIdModel = allOrderIdModelFromJson(jsonString);

import 'dart:convert';

AllOrderIdModel allOrderIdModelFromJson(String str) => AllOrderIdModel.fromJson(json.decode(str));

String allOrderIdModelToJson(AllOrderIdModel data) => json.encode(data.toJson());


class AllOrderIdModel {
  bool? status;
  List<Data>? data;
  String? message;

  AllOrderIdModel({this.status, this.data, this.message});

  AllOrderIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;

  Data(
      {this.id,
       });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    return data;
  }
}


