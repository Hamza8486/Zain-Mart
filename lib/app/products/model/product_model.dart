// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());



class ProductModel {
  bool? status;
  List<ProductAllModel>? data;
  String? message;

  ProductModel({this.status, this.data, this.message});

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ProductAllModel>[];
      json['data'].forEach((v) {
        data!.add(new ProductAllModel.fromJson(v));
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

class ProductAllModel {
  int? id;
  String? subCategoryId;
  String? title;
  String? unit;
  int? quantity;
  String? wholesellPrice;
  String? sellingPrice;
  String? discount;
  String? promote;
  String? status;
  String? description;
  String? createdAt;
  String? updatedAt;
  List<ProductImages>? productImages;

  ProductAllModel(
      {this.id,
        this.subCategoryId,
        this.title,
        this.unit,
        this.quantity,
        this.wholesellPrice,
        this.sellingPrice,
        this.discount,
        this.promote,
        this.status,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.productImages});

  ProductAllModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subCategoryId = json['sub_category_id'];
    title = json['title'];
    unit = json['unit'];
    quantity = json['quantity'];
    wholesellPrice = json['wholesell_price'];
    sellingPrice = json['selling_price'];
    discount = json['discount'];
    promote = json['promote'];
    status = json['status'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(new ProductImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_category_id'] = this.subCategoryId;
    data['title'] = this.title;
    data['unit'] = this.unit;
    data['quantity'] = this.quantity;
    data['wholesell_price'] = this.wholesellPrice;
    data['selling_price'] = this.sellingPrice;
    data['discount'] = this.discount;
    data['promote'] = this.promote;
    data['status'] = this.status;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.productImages != null) {
      data['product_images'] =
          this.productImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductImages {
  int? id;
  String? productId;
  String? image;
  String? createdAt;
  String? updatedAt;

  ProductImages(
      {this.id, this.productId, this.image, this.createdAt, this.updatedAt});

  ProductImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
