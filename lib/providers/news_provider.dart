import 'package:flutter/foundation.dart';
import 'package:newsrestapi/services/models/news_model.dart';
import 'package:newsrestapi/services/news_api.dart';

class NewsProvider with ChangeNotifier {
  List<NewsModel> newsList = [];
  List<NewsModel> get getNewsList {
    return [...newsList];
  }

  Future<List<NewsModel>> fetchAllNews(
      {required int pageIndex, required String sortBy}) async {
    newsList =
        await NewsApiServices.getAllNews(page: pageIndex, sortBy: sortBy);
    return newsList;
  }

  NewsModel findByDate({required String publishedAt}) {
    return newsList.firstWhere((element) => element.publishedAt == publishedAt);
  }

  Future<List<NewsModel>> fetchTopHeadlines() async {
    newsList = await NewsApiServices.getTopHeadlines();
    return newsList;
  }
}
