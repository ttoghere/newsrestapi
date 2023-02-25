import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsrestapi/inner_screens/search_screen.dart';
import 'package:newsrestapi/providers/news_provider.dart';
import 'package:newsrestapi/services/models/news_model.dart';
import 'package:newsrestapi/services/news_api.dart';
import 'package:newsrestapi/widgets/articles_widget.dart';
import 'package:newsrestapi/widgets/empty_screen.dart';
import 'package:newsrestapi/widgets/loading_widget.dart';
import 'package:newsrestapi/widgets/tabs.dart';
import 'package:newsrestapi/consts/utils.dart';
import 'package:newsrestapi/consts/vars.dart';
import 'package:newsrestapi/widgets/drawer_widget.dart';
import 'package:newsrestapi/widgets/top_tending.dart';
import 'package:newsrestapi/widgets/vertical_spacing.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var newsType = NewsType.allNews;
  int currentPageIndex = 0;
  String sortBy = SortByEnum.publishedAt.name;

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context: context);
    Size size = utils.getScreenSize;
    final newsProvider = Provider.of<NewsProvider>(context);
    final Color color = utils.getColor;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: color),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            'News app',
            style: GoogleFonts.lobster(
                textStyle:
                    TextStyle(color: color, fontSize: 20, letterSpacing: 0.6)),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const SearchScreen(),
                      inheritTheme: true,
                      ctx: context),
                );
              },
              icon: const Icon(
                IconlyLight.search,
              ),
            )
          ],
        ),
        drawer: const DrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              children: [
                TabsWidget(
                  text: 'All news',
                  color: newsType == NewsType.allNews
                      ? Theme.of(context).cardColor
                      : Theme.of(context).cardColor.withOpacity(0.6),
                  function: () {
                    if (newsType == NewsType.allNews) {
                      return;
                    }
                    setState(() {
                      newsType = NewsType.allNews;
                    });
                  },
                  fontSize: newsType == NewsType.allNews ? 22 : 14,
                ),
                const SizedBox(
                  width: 25,
                ),
                TabsWidget(
                  text: 'Top trending',
                  color: newsType == NewsType.topTrending
                      ? Theme.of(context).cardColor
                      : Theme.of(context).cardColor.withOpacity(0.6),
                  function: () {
                    if (newsType == NewsType.topTrending) {
                      return;
                    }
                    setState(() {
                      newsType = NewsType.topTrending;
                    });
                  },
                  fontSize: newsType == NewsType.topTrending ? 22 : 14,
                ),
              ],
            ),
            const VerticalSpacing(10),
            newsType == NewsType.topTrending
                ? Container()
                : SizedBox(
                    height: kBottomNavigationBarHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        paginationButtons(
                          text: "Prev",
                          function: () {
                            if (currentPageIndex == 0) {
                              return;
                            }
                            setState(() {
                              currentPageIndex -= 1;
                            });
                          },
                        ),
                        Flexible(
                          flex: 2,
                          child: ListView.builder(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: ((context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    color: currentPageIndex == index
                                        ? Theme.of(context)
                                            .colorScheme
                                            .secondary
                                        : Theme.of(context).cardColor,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          currentPageIndex = index;
                                        });
                                      },
                                      child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${index + 1}",
                                          style: TextStyle(
                                            color: currentPageIndex == index
                                                ? Colors.white
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                          ),
                                        ),
                                      )),
                                    ),
                                  ),
                                );
                              })),
                        ),
                        paginationButtons(
                          text: "Next",
                          function: () {
                            if (currentPageIndex == 4) {
                              return;
                            }
                            setState(() {
                              currentPageIndex += 1;
                            });
                            // print('$currentPageIndex index');
                          },
                        ),
                      ],
                    ),
                  ),
            const VerticalSpacing(10),
            newsType == NewsType.topTrending
                ? Container()
                : Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton(
                          value: sortBy,
                          items: dropDownItems,
                          onChanged: (String? value) {
                            setState(() {
                              sortBy = value!;
                            });
                          }),
                    ),
                  ),
            FutureBuilder<List<NewsModel>>(
                future: newsProvider.fetchAllNews(
                  pageIndex: currentPageIndex + 1,
                  sortBy: sortBy,
                ),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return newsType == NewsType.allNews
                        ? LoadingWidget(newsType: newsType)
                        : Expanded(child: LoadingWidget(newsType: newsType));
                  } else if (snap.hasError) {
                    return EmptyNewsWidget(
                        text: "An Error Occured: ${snap.hasError}",
                        imagePath: "assets/images/no_news.png");
                  } else if (snap.data == null) {
                    return EmptyNewsWidget(
                      text: "An Error Occured: ${snap.hasError}",
                      imagePath: "assets/images/no_news.png",
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snap.data!.length,
                        itemBuilder: (ctx, index) {
                          return ChangeNotifierProvider.value(
                            value: snap.data![index],
                            child: ArticlesWidget(),
                          );
                        }),
                  );
                }),
          ]),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> get dropDownItems {
    List<DropdownMenuItem<String>> menuItem = [
      DropdownMenuItem(
        value: SortByEnum.relevancy.name,
        child: Text(
          SortByEnum.relevancy.name,
          style: TextStyle(color: Theme.of(context).cardColor.withOpacity(0.6)),
        ),
      ),
      DropdownMenuItem(
        value: SortByEnum.publishedAt.name,
        child: Text(
          SortByEnum.publishedAt.name,
          style: TextStyle(color: Theme.of(context).cardColor.withOpacity(0.6)),
        ),
      ),
      DropdownMenuItem(
        value: SortByEnum.popularity.name,
        child: Text(
          SortByEnum.popularity.name,
          style: TextStyle(color: Theme.of(context).cardColor.withOpacity(0.6)),
        ),
      ),
    ];
    return menuItem;
  }

  Widget paginationButtons({required Function function, required String text}) {
    return ElevatedButton(
      onPressed: () {
        function();
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          padding: const EdgeInsets.all(6),
          textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor)),
      child: Text(text),
    );
  }
}
