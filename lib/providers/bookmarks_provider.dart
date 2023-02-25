import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsrestapi/consts/vars.dart';
import 'package:newsrestapi/services/models/bookmarks_model.dart';

class BookmarksProvider with ChangeNotifier {
  List<BookmarksModel> _bookmarkList = [];
  List<BookmarksModel> get bookmarksList {
    return [..._bookmarkList];
  }

  Future<void> addToBookmark() async {
    try {
      var uri = Uri.https(fBaseUrl, "bookmarks.json");
      var response = await http.post(
        uri,
        headers: {"Test": "Anytest"},
      );
      log("Status Code: ${response.statusCode}");
      log("Body: ${response.body}");
    } catch (error) {
      log(error.toString());
    }
  }
}
