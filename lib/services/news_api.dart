import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:newsrestapi/consts/vars.dart';
import 'package:newsrestapi/services/models/news_model.dart';

class NewsApiServices {
  static Future<List<NewsModel>> getAllNews() async {
    try {
      var uri = Uri.https(baseUrl, "v2/everything",
          {"q": "bitcoin", "pageSize": "5", "domains": "techcrunch.com"});
      var response = await http.get(
        uri,
        headers: {
          "X-Api-key": apiKey,
        },
      );
      // log("Response StatusCode:  ${response.statusCode}");
      Map data = jsonDecode(response.body);
      List newsTempList = [];
      if (data['code'] != null) {
        throw HttpException(data['code']);
      }
      for (var v in data["articles"]) {
        newsTempList.add(v);
      }
      return NewsModel.newsFromSnapshot(newsTempList);
    } catch (error) {
      throw error.toString();
    }
  }
}
