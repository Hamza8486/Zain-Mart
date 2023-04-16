// To parse this JSON data, do
//
//     final cartListModel = cartListModelFromJson(jsonString);

import 'dart:convert';

CartListModel cartListModelFromJson(String str) => CartListModel.fromJson(json.decode(str));

String cartListModelToJson(CartListModel data) => json.encode(data.toJson());



class CartListModel {
  bool? status;
  Data? data;
  String? message;

  CartListModel({this.status, this.data, this.message});

  CartListModel.fromJson(Map<String, dynamic> json) {
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
  List<Cart>? cart;
  var total;
  var discount;

  Data({this.cart, this.total, this.discount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(new Cart.fromJson(v));
      });
    }
    total = json['total'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cart != null) {
      data['cart'] = this.cart!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['discount'] = this.discount;
    return data;
  }
}

class Cart {
  int? id;
  String? userId;
  String? productId;
  int? quantity;
  String? amount;
  String? discount;
  String? createdAt;
  String? updatedAt;
  Product? product;

  Cart(
      {this.id,
        this.userId,
        this.productId,
        this.quantity,
        this.amount,
        this.discount,
        this.createdAt,
        this.updatedAt,
        this.product});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    amount = json['amount'];
    discount = json['discount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
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
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
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
  var description;
  String? createdAt;
  String? updatedAt;
  List<ProductImages>? productImages;

  Product(
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

  Product.fromJson(Map<String, dynamic> json) {
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

