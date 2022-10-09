import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/model/article.dart';
import 'package:news_api_flutter_package/model/error.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';
import 'package:news_app/constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GetArticleSlider extends StatefulWidget {
  const GetArticleSlider({super.key});

  @override
  State<GetArticleSlider> createState() => _GetArticleSliderState();
}

class _GetArticleSliderState extends State<GetArticleSlider> {
  final NewsAPI _newsAPI = NewsAPI("");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<List<Article>>(
            future: _newsAPI.getTopHeadlines(country: "tr"),
            builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
              return snapshot.connectionState == ConnectionState.done
                  ? snapshot.hasData
                      ? _buildArticlePages(
                          snapshot.data!,
                        )
                      : _buildError(snapshot.error as ApiError)
                  : _buildProgress();
            }),
      ],
    );
  }
}

Widget _buildArticlePages(List<Article> articles) {
  final controller = PageController(viewportFraction: 1, keepPage: true);
  final pages = List.generate(
      10,
      (index) => Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(articles[index].urlToImage.toString()))),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: SizedBox(
              height: 280,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${articles[index].title}',
                        style: const TextStyle(fontFamily: 'NewsReader-Regular', fontSize: 20),
                      ),
											
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ));
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: SizedBox(
            height: 220,
            child: PageView.builder(
                itemCount: pages.length,
                controller: controller,
                itemBuilder: (_, index) {
                  return pages[index % pages.length];
                })),
      ),
      SmoothPageIndicator(
          controller: controller,
          count: pages.length,
          effect: const ScrollingDotsEffect(
						activeDotColor: ProjectColors.colorMarigold,
						dotColor: ProjectColors.colorWhite,
            activeStrokeWidth: 2.6,
            activeDotScale: 1.3,
            maxVisibleDots: 5,
            radius: 8,
            spacing: 10,
            dotHeight: 12,
            dotWidth: 12,
          )),
    ],
  );
}

Widget _buildProgress() {
  return const Center(child: CircularProgressIndicator());
}

Widget _buildError(ApiError error) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            error.code ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 4),
          Text(error.message!, textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}
