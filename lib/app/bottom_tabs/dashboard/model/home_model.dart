// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());
class HomeModel {
  bool? status;
  Data? data;
  String? message;

  HomeModel({this.status, this.data, this.message});

  HomeModel.fromJson(Map<String, dynamic> json) {
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
  List<Categories>? categories;
  List<Banners>? banners;
  List<Updates>? updates;
  List<AboutUs>? aboutUs;

  Data({this.categories, this.banners, this.updates, this.aboutUs});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
    if (json['updates'] != null) {
      updates = <Updates>[];
      json['updates'].forEach((v) {
        updates!.add(new Updates.fromJson(v));
      });
    }
    if (json['about_us'] != null) {
      aboutUs = <AboutUs>[];
      json['about_us'].forEach((v) {
        aboutUs!.add(new AboutUs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    if (this.updates != null) {
      data['updates'] = this.updates!.map((v) => v.toJson()).toList();
    }
    if (this.aboutUs != null) {
      data['about_us'] = this.aboutUs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? image;
  String? promote;
  var description;
  String? createdAt;
  String? updatedAt;
  List<SubCategories>? subCategories;

  Categories(
      {this.id,
        this.name,
        this.image,
        this.promote,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.subCategories});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    promote = json['promote'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['sub_categories'] != null) {
      subCategories = <SubCategories>[];
      json['sub_categories'].forEach((v) {
        subCategories!.add(new SubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['promote'] = this.promote;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.subCategories != null) {
      data['sub_categories'] =
          this.subCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategories {
  int? id;
  String? categoryId;
  String? name;
  String? image;
  var description;
  String? createdAt;
  String? updatedAt;

  SubCategories(
      {this.id,
        this.categoryId,
        this.name,
        this.image,
        this.description,
        this.createdAt,
        this.updatedAt});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Banners {
  int? id;
  String? banner;
  String? type;
  String? createdAt;
  String? updatedAt;

  Banners({this.id, this.banner, this.type, this.createdAt, this.updatedAt});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    banner = json['banner'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner'] = this.banner;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Updates {
  int? id;
  String? update;
  String? image;
  String? createdAt;
  String? updatedAt;

  Updates({this.id, this.update, this.image, this.createdAt, this.updatedAt});

  Updates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    update = json['update'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['update'] = this.update;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class AboutUs {
  int? id;
  String? aboutUs;
  String? createdAt;
  String? updatedAt;

  AboutUs({this.id, this.aboutUs, this.createdAt, this.updatedAt});

  AboutUs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aboutUs = json['about_us'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['about_us'] = this.aboutUs;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
