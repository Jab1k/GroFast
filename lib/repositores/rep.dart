import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/model.dart';

abstract class GetInfo {
  GetInfo._();

  static Future<List<ProductModel?>?> getProduct() async {
    try {
      final url = Uri.parse("https://fakestoreapi.com/products");
      final res = await http.get(url);
      return productModelFromJson(res.body);
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<List> gethamma() async {
    try {
      final url = Uri.parse("https://fakestoreapi.com/products/categories");
      final res = await http.get(url);
      print(res.body);
      return jsonDecode(res.body);
    } catch (e) {
      print(e);
    }
    return [];
  }

  static Future<List<ProductModel?>?> Getcotegories(String cat) async {
    try {
      final url = Uri.parse("https://fakestoreapi.com/products/category/$cat");
      final res = await http.get(url);
      return productModelFromJson(res.body);
    } catch (e) {
      print(e);
    }
    return null;
  }
}
