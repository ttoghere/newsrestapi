import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:newsrestapi/consts/vars.dart';
import 'package:newsrestapi/services/models/news_model.dart';

class NewsApiServices {
  static Future<List<NewsModel>> getAllNews(
      {required int page, required String sortBy}) async {
    try {
      var uri = Uri.https(baseUrl, "v2/everything", {
        "q": "bitcoin",
        "pageSize": "5",
        "domains": "techcrunch.com",
        "page": page.toString(),
        "sortBy": sortBy,
      });
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

  static Future<List<NewsModel>> getTopHeadlines() async {
    try {
      var uri = Uri.https(baseUrl, "v2/top-headlines", {
        "country": "us",
      });
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
