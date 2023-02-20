import 'package:flutter/foundation.dart';
import 'package:newsrestapi/services/models/news_model.dart';
import 'package:newsrestapi/services/news_api.dart';

class NewsProvider with ChangeNotifier {
  List<NewsModel> newsList = [];
  List<NewsModel> get getNewsList {
    return [...newsList];
  }

  Future<List<NewsModel>> fetchAllNews({required int pageIndex}) async {
    newsList = await NewsApiServices.getAllNews(page:pageIndex);
    return newsList;
  }
}
