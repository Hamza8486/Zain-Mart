// To parse this JSON data, do
//
//     final getOrdersModel = getOrdersModelFromJson(jsonString);

import 'dart:convert';

GetOrdersModel getOrdersModelFromJson(String str) => GetOrdersModel.fromJson(json.decode(str));

String getOrdersModelToJson(GetOrdersModel data) => json.encode(data.toJson());


class GetOrdersModel {
  bool? status;
  Data? data;
  String? message;

  GetOrdersModel({this.status, this.data, this.message});

  GetOrdersModel.fromJson(Map<String, dynamic> json) {
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
  List<Active>? active;
  List<Active>? complete;

  Data({this.active, this.complete});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['active'] != null) {
      active = <Active>[];
      json['active'].forEach((v) {
        active!.add(new Active.fromJson(v));
      });
    }
    if (json['complete'] != null) {
      complete = <Active>[];
      json['complete'].forEach((v) {
        complete!.add(new Active.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.active != null) {
      data['active'] = this.active!.map((v) => v.toJson()).toList();
    }
    if (this.complete != null) {
      data['complete'] = this.complete!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Active {
  int? id;
  String? userId;
  String? deliveryAddressId;
  String? total;
  String? status;
  String? deliveryDate;
  var instructions;
  String? createdAt;
  String? updatedAt;
  List<OrderProducts>? orderProducts;
  DeliveryAddress? deliveryAddress;

  Active(
      {this.id,
        this.userId,
        this.deliveryAddressId,
        this.total,
        this.status,
        this.deliveryDate,
        this.instructions,
        this.createdAt,
        this.updatedAt,
        this.orderProducts,

        this.deliveryAddress});

  Active.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    deliveryAddressId = json['delivery_address_id'];
    total = json['total'];
    status = json['status'];
    deliveryDate = json['delivery_date'];
    instructions = json['instructions'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['order_products'] != null) {
      orderProducts = <OrderProducts>[];
      json['order_products'].forEach((v) {
        orderProducts!.add(new OrderProducts.fromJson(v));
      });
    }

    deliveryAddress = json['delivery_address'] != null
        ? new DeliveryAddress.fromJson(json['delivery_address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['delivery_address_id'] = this.deliveryAddressId;
    data['total'] = this.total;
    data['status'] = this.status;
    data['delivery_date'] = this.deliveryDate;
    data['instructions'] = this.instructions;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.orderProducts != null) {
      data['order_products'] =
          this.orderProducts!.map((v) => v.toJson()).toList();
    }

    if (this.deliveryAddress != null) {
      data['delivery_address'] = this.deliveryAddress!.toJson();
    }
    return data;
  }
}

class OrderProducts {
  int? id;
  String? orderId;
  String? productId;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  Product? product;

  OrderProducts(
      {this.id,
        this.orderId,
        this.productId,
        this.quantity,
        this.createdAt,
        this.updatedAt,
        this.product});

  OrderProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
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

class DeliveryAddress {
  int? id;
  String? userId;
  String? name;
  String? streetNo;
  String? location;
  String? createdAt;
  String? updatedAt;

  DeliveryAddress(
      {this.id,
        this.userId,
        this.name,
        this.streetNo,
        this.location,
        this.createdAt,
        this.updatedAt});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    streetNo = json['street_no'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['street_no'] = this.streetNo;
    data['location'] = this.location;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
