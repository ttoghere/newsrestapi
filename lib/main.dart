//Packages
import 'package:flutter/material.dart';
import 'package:newsrestapi/inner_screens/blog_details.dart';
import 'package:newsrestapi/providers/bookmarks_provider.dart';
import 'package:newsrestapi/providers/news_provider.dart';
import 'package:provider/provider.dart';

//Screens
import 'screens/home_screen.dart';

//Consts
import 'consts/theme_data.dart';

//Providers
import 'providers/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Need it to access the theme Provider
  ThemeProvider themeChangeProvider = ThemeProvider();

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  //Fetch the current theme
  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
        //This provider is for notify about theme changes
          return themeChangeProvider;
        }),
        //This provider is for the news actions
        ChangeNotifierProvider(
          create: (_) => NewsProvider(),
        ),
        //This provider is for the bookmark actions
        ChangeNotifierProvider(
          create: (_) => BookmarksProvider(),
        ),
      ],
      child:
          //Notify about theme changes
          Consumer<ThemeProvider>(
        builder: (context, themeChangeProvider, ch) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Blog',
            theme: Styles.themeData(themeChangeProvider.getDarkTheme, context),
            home: const HomeScreen(),
            routes: {
              NewsDetailsScreen.routeName: (context) => NewsDetailsScreen(),
            },
          );
        },
      ),
    );
  }
}
