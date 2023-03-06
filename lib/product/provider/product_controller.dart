import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../model/product_model.dart';

class ProductController {
  static const String BASE_URL = "http://demo25.ninavietnam.com.vn/api/sourcefull888/api/api_product.php";

  static final futureCategoryProvider = FutureProvider.autoDispose<List<Category>?>((ref) async {
    final Response reponse = await Dio().get("$BASE_URL/?act=get_product_list");
    if (reponse.statusCode == 200) {
      List<Category> listCategory = [];
      var getData = reponse.data as List;
      listCategory = getData.map((i) => Category.fromJson(i)).toList();
      return listCategory;
    }else{
      throw Exception("Error Fetching");
    }
  });

  static final futureProductProvider = FutureProvider.autoDispose<List<ProductModel>?>((ref) async {
    final Response reponse = await Dio().get("$BASE_URL/?act=get_product");
    if (reponse.statusCode == 200) {
      List<ProductModel> listProduct = [];
      var getData = reponse.data as List;
      listProduct = getData.map((i) => ProductModel.fromJson(i)).toList();
      return listProduct;
    }else{
      throw Exception("Error Fetching");
    }
  });

  static final futureProductCategoryProvider = FutureProvider.autoDispose.family<List<ProductModel>?, String>((ref, id)  async {
    final Response reponse = await Dio().get("$BASE_URL/?act=get_product_by_id&categoryId=$id");
    List<ProductModel> listProduct = [];
    if (reponse.statusCode == 200) {
      var getData = reponse.data as List;
      listProduct = getData.map((i) => ProductModel.fromJson(i)).toList();
      return listProduct;
    }else{
      throw Exception("Error Fetching");
    }
  });

  static final futureProductDetailProvider = FutureProvider.autoDispose.family<ProductModel?, String>((ref, id)  async {
    final Response reponse = await Dio().get("$BASE_URL/?act=get_product_detail&id=$id");
    if (reponse.statusCode == 200) {
      var getData = reponse.data;
      var listProduct = ProductModel.fromJson(getData);
      return listProduct;
    }else{
      throw Exception("Error Fetching");
    }
  });

  static Future<List<ProductModel>> getListCart() async {
    try {
      Response response = await Dio().get("$BASE_URL/?offset=0&limit=3");
      var getData = response.data as List;
      var listProduct = getData.map((i) => ProductModel.fromJson(i)).toList();
      return listProduct;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}

