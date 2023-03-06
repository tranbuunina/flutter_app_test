class ProductModel {
  ProductModel({
      this.id, 
      this.photo, 
      this.name, 
      this.regularPrice, 
      this.salePrice, 
      this.discount, 
      this.desc, 
      this.content, 
      this.idList, 
      this.gallery, 
      this.category, 
      this.listSize,});

  ProductModel.fromJson(dynamic json) {
    id = json['id'];
    photo = json['photo'];
    name = json['name'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    discount = json['discount'];
    desc = json['desc'];
    content = json['content'];
    idList = json['id_list'];
    gallery = json['gallery'] != null ? json['gallery'].cast<String>() : [];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['list_size'] != null) {
      listSize = [];
      json['list_size'].forEach((v) {
        listSize?.add(ListSize.fromJson(v));
      });
    }
  }
  num? id;
  String? photo;
  String? name;
  num? regularPrice;
  num? salePrice;
  num? discount;
  String? desc;
  String? content;
  String? idList;
  List<String>? gallery;
  Category? category;
  List<ListSize>? listSize;
ProductModel copyWith({  num? id,
  String? photo,
  String? name,
  num? regularPrice,
  num? salePrice,
  num? discount,
  String? desc,
  String? content,
  String? idList,
  List<String>? gallery,
  Category? category,
  List<ListSize>? listSize,
}) => ProductModel(  id: id ?? this.id,
  photo: photo ?? this.photo,
  name: name ?? this.name,
  regularPrice: regularPrice ?? this.regularPrice,
  salePrice: salePrice ?? this.salePrice,
  discount: discount ?? this.discount,
  desc: desc ?? this.desc,
  content: content ?? this.content,
  idList: idList ?? this.idList,
  gallery: gallery ?? this.gallery,
  category: category ?? this.category,
  listSize: listSize ?? this.listSize,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['photo'] = photo;
    map['name'] = name;
    map['regular_price'] = regularPrice;
    map['sale_price'] = salePrice;
    map['discount'] = discount;
    map['desc'] = desc;
    map['content'] = content;
    map['id_list'] = idList;
    map['gallery'] = gallery;
    if (category != null) {
      map['category'] = category?.toJson();
    }
    if (listSize != null) {
      map['list_size'] = listSize?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ListSize {
  ListSize({
      this.id, 
      this.namevi,});

  ListSize.fromJson(dynamic json) {
    id = json['id'];
    namevi = json['namevi'];
  }
  String? id;
  String? namevi;
ListSize copyWith({  String? id,
  String? namevi,
}) => ListSize(  id: id ?? this.id,
  namevi: namevi ?? this.namevi,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['namevi'] = namevi;
    return map;
  }

}

class Category {
  Category({
      this.id, 
      this.namevi,});

  Category.fromJson(dynamic json) {
    id = json['id'];
    namevi = json['namevi'];
  }
  String? id;
  String? namevi;
Category copyWith({  String? id,
  String? namevi,
}) => Category(  id: id ?? this.id,
  namevi: namevi ?? this.namevi,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['namevi'] = namevi;
    return map;
  }

}