// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsrestapi/inner_screens/blog_details.dart';
import 'package:newsrestapi/providers/news_provider.dart';
import 'package:newsrestapi/services/models/news_model.dart';
import 'package:page_transition/page_transition.dart';

import 'package:newsrestapi/consts/utils.dart';
import 'package:provider/provider.dart';

import '../inner_screens/news_details_webview.dart';

class TopTrendingWidget extends StatelessWidget {
  const TopTrendingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context: context);
    final size = utils.getScreenSize;
    final newsProvider = Provider.of<NewsModel>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(NewsDetailsScreen.routeName,
                arguments: newsProvider.publishedAt);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  boxFit: BoxFit.fill,
                  errorWidget: Image.asset('assets/images/empty_image.png'),
                  imageUrl: newsProvider.urlToImage,
                  height: size.height * 0.33,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  newsProvider.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Theme.of(context).colorScheme.secondary),
                  overflow: TextOverflow.fade,
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: NewsDetailsWebView(
                                url: newsProvider.url,
                              ),
                              inheritTheme: true,
                              ctx: context),
                        );
                      },
                      icon: Icon(Icons.link,
                          color: Theme.of(context).colorScheme.secondary)),
                  const Spacer(),
                  SelectableText(
                    newsProvider.publishedAt,
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
