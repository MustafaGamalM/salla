class CategoriesModel {
  bool status;
  CategoryData data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? CategoryData.fromJson(json['data']) : null;
  }
}

class CategoryData {
  int currentPage;
  List<CatDataModel> data = [];
  CategoryData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((v) {
      data.add(CatDataModel.fromJson(v));
    });
  }
}

class CatDataModel {
  int id;
  String name;
  String image;

  CatDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
