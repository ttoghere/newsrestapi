import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsrestapi/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class Utils {
  BuildContext context;
  Utils({required this.context});

  Size get getScreenSize => MediaQuery.of(context).size;
  bool get getTheme => Provider.of<ThemeProvider>(context).getDarkTheme;
  Color get getColor => getTheme ? Colors.white : Colors.black;

  Color get baseShimmerColor =>
      getTheme ? Colors.grey.shade500 : Colors.grey.shade200;

  Color get highlightShimmerColor =>
      getTheme ? Colors.grey.shade700 : Colors.grey.shade400;

  Color get widgetShimmerColor =>
      getTheme ? Colors.grey.shade600 : Colors.grey.shade100;
  TextStyle smallTextStyle = GoogleFonts.montserrat(
    fontSize: 15,
  );
  TextStyle titleTextStyle =
      GoogleFonts.oswald(fontSize: 28, fontWeight: FontWeight.bold);
}
