import 'dart:convert';

import 'package:wordpresstest/models/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:wordpresstest/models/product_item.dart';

import '../config.dart';

class APIService {
  static var client = http.Client();

  static Future<List<CategoryModel>?> getCategories() async {
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
      'Authorization': 'Basic ${base64Encode(
        utf8.encode(
          '${Config.key}:${Config.secret}',
        ),
      )}'
    };
    Map<String, dynamic> queryString = {
      //'consumer_key': Config.key,
      //'consumer_secret': Config.secret,
      'parent': '0',
      '_fields[]': ['id', 'name', 'image'],
      'per_page': '100',
      'page': '1',
    };

    var url = Uri.https(
      Config.apiURL.trim(),
      Config.apiEndPoint.trim() + Config.categoriesURL.trim(),
      queryString,
    );

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return categoriesFromJson(data);
    } else {
      return null;
    }
  }

  static Future<List<ProductModel>?> getProducts({
    int? pageNumber,
    int? pageSize,
    String? strSearch,
    String? categoryId,
    String? sortBy,
    List<int>? productIds,
    String? sortOrder = " asc",
  }) async {
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
    };

    Map<String, dynamic> queryString = {
      'consumer_key': Config.key,
      'consumer_secret': Config.secret,
      'parent': '0',
      '_fields[]': [
        'id',
        'name',
        'price',
        'regular_price',
        'sale_price',
        'short_description',
        'images'
      ],
    };

    if (strSearch != null) {
      queryString["search"] = strSearch;
    }

    if (pageSize != null) {
      queryString["per_page"] = pageSize.toString();
    }

    if (pageNumber != null) {
      queryString["page"] = pageNumber.toString();
    }

    if (categoryId != null) {
      if (strSearch == "" || strSearch == null) {
        queryString["category"] = categoryId;
      }
    }

    if (sortBy != null) {
      queryString["orderBy"] = sortBy;
    }

    queryString["order"] = sortOrder;

    if (productIds != null) {
      queryString["include"] = productIds.join(",").toString();
    }

    var url = Uri.https(
      Config.apiURL,
      Config.apiEndPoint + Config.productsURL,
      queryString,
    );

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return productsFromJson(data);
    } else {
      return null;
    }
  }

  //

  static Future<ProductModel?> getProductDetails({productId}) async {
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
      'Authorization': 'Basic ${base64Encode(
        utf8.encode(
          '${Config.key}:${Config.secret}',
        ),
      )}'
    };

    Map<String, dynamic> queryString = {
      // 'consumer_key': Config.key,
      // 'consumer_secret': Config.secret,
      'parent': '0',
      '_fields[]': [
        'id',
        'name',
        'price',
        'regular_price',
        'sale_price',
        'short_description',
        'images'
            'cross_sell_ids'
      ],
    };

    var url = Uri.https(
      Config.apiURL,
      "${Config.apiEndPoint}${Config.productsURL}/$productId",
      queryString,
    );

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return ProductModel.fromJson(data);
    } else {
      return null;
    }
  }
}
