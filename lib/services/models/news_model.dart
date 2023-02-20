import 'package:newsrestapi/services/global_methods.dart';
import 'package:reading_time/reading_time.dart';

class NewsModel {
  String newsId,
      sourceName,
      authorName,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      dateToShow,
      content,
      readingTimeText;

  NewsModel({
    required this.newsId,
    required this.sourceName,
    required this.authorName,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.dateToShow,
    required this.readingTimeText,
  });

  factory NewsModel.fromJson(dynamic json) {
    String title = json["title"] ?? "";
    String content = json["content"] ?? "";
    String description = json["description"] ?? "";
    String dateToShow = "";
    if (json["publishedAt"] != null) {
      dateToShow = GlobalMethods.formattedText(json["publishedAt"]);
    }
    return NewsModel(
      newsId: json["source"]["id"] ?? "",
      sourceName: json["source"]["name"] ?? "",
      authorName: json["author"] ?? "",
      title: title,
      description: description,
      url: json["url"] ?? "",
      urlToImage: json["urlToImage"] ??
          "https://scontent.fadb2-1.fna.fbcdn.net/v/t1.6435-9/140319041_1151557678629753_2291501919177660954_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=e3f864&_nc_ohc=ZtUJrEeXy-UAX9P-Zwo&_nc_ht=scontent.fadb2-1.fna&oh=00_AfDXJ0GU1Y-VbLmjJpOxINTfWQ3qzRDRoc6k68SjC7SSOw&oe=6419C53F",
      publishedAt: json["publishedAt"] ?? "",
      content: content,
      dateToShow: dateToShow,
      readingTimeText: readingTime(title + description + content).msg,
    );
  }

  static List<NewsModel> newsFromSnapshot(List newSnapshot) {
    return newSnapshot.map((json) {
      return NewsModel.fromJson(json);
    }).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["NewsId"] = newsId;
    data["sourceName"] = sourceName;
    data["authorName"] = authorName;
    data["title"] = title;
    data["description"] = description;
    data["url"] = url;
    data["urlToImage"] = urlToImage;
    data["publishedAt"] = publishedAt;
    data["dateToShow"] = dateToShow;
    data["content"] = content;
    data["readingTimeText"] = readingTimeText;
    return data;
  }

  @override
  String toString() {
    return "news: {newId: $newsId}";
  }
}
