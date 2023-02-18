import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsrestapi/consts/utils.dart';
import 'package:newsrestapi/widgets/empty_screen.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context: context).getScreenSize;
    final Color color = Utils(context: context).getColor;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'Bookmarks',
          style: GoogleFonts.lobster(
              textStyle:
                  TextStyle(color: color, fontSize: 20, letterSpacing: 0.6)),
        ),
      ),
      body: const EmptyNewsWidget(
        text: 'You didn\'t add anything yet to your bookmarks',
        imagePath: "assets/images/bookmark.png",
      ),
    );
  }
}