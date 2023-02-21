import 'package:flutter/foundation.dart';
import 'package:newsrestapi/services/global_methods.dart';
import 'package:reading_time/reading_time.dart';

class BookmarksModel with ChangeNotifier {
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

  BookmarksModel({
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

  factory BookmarksModel.fromJson(dynamic json) {
    String title = json["title"] ?? "";
    String content = json["content"] ?? "";
    String description = json["description"] ?? "";
    String dateToShow = "";
    if (json["publishedAt"] != null) {
      dateToShow = GlobalMethods.formattedText(json["publishedAt"]);
    }
    return BookmarksModel(
      newsId: json["newsId"] ?? "",
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

  static List<BookmarksModel> bookmarksFromSnapshot(List newSnapshot) {
    return newSnapshot.map((json) {
      return BookmarksModel.fromJson(json);
    }).toList();
  }

  @override
  String toString() {
    return "news: {newId: $newsId}, {sourceName: $sourceName}, {authorName: $authorName}, {url: $url}, {description: $description}, {urlToImage: $urlToImage}, {publishedAt: $publishedAt}, {content: $content}, {title: $title}, {dateToShow: $dateToShow}, {readingTimeText: $readingTimeText},";
  }
}
