import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/model/article.dart';
import 'package:news_api_flutter_package/model/error.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';
import 'package:news_app/constants/colors.dart';
import 'package:news_app/constants/text_styles.dart';

class TrendWidget extends StatefulWidget {
  const TrendWidget({super.key});

  @override
  State<TrendWidget> createState() => _TrendWidgetState();
}

class _TrendWidgetState extends State<TrendWidget> {
  final NewsAPI _newsAPI = NewsAPI("");
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: _newsAPI.getTopHeadlines(country: 'tr'),
      builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? snapshot.hasData
                ? _buildSourceList(snapshot.data!)
                : _buildError(snapshot.error as ApiError)
            : _buildProgress();
      },
    );
  }

  ListView _buildSourceList(List<Article> articles) {
    final trends = List.generate(
        5,
        (index) => Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: OutlinedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(ProjectColors.colorWhite),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ))),
                onPressed: () {},
                child: SizedBox(
                    height: 32,
                    child: Center(
                      child: Text(
                        '${articles[index].author?.toLowerCase()}',
                        style: ProjectTextStyle.mainTextStyle,
                      ),
                    )),
              ),
            ));
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: trends.length,
      itemBuilder: (BuildContext context, int index) {
        return trends[index % trends.length];
      },
    );
  }
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
