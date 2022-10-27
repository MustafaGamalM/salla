class HomeModel {
  bool status;
  Data data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Banners> banners = [];
  List<Products> products = [];

  Data.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((v) {
      banners.add(Banners.fromJson(v));
    });

    json['products'].forEach((v) {
      products.add(Products.fromJson(v));
    });
  }
}

class Banners {
  int id;
  String image;

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class Products {
  int id;
  dynamic price;
  dynamic oldPrice;
  int discount;
  String image;
  String name;
  bool inFavorites;
  bool inCart;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
