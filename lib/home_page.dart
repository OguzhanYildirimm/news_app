import 'package:flutter/material.dart';
import 'package:news_app/constants/colors.dart';
import 'package:news_app/constants/text_styles.dart';
import 'package:news_app/widgets/article_slider.dart';
import 'package:news_app/widgets/trends.dart';
import 'package:outline_search_bar/outline_search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        body: Padding(
          padding: const EdgeInsets.only(top: 24, left: 8.0, right: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                height16(),
                customTopWidget(),
                height16(),
                Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Haber Kaynakları',style: ProjectTextStyle.subtitleTextStyle,
                            )),
														Divider(thickness: 2,color: Colors.amber,),
                        SizedBox(height: 32, child: TrendWidget()),
												Divider(thickness: 2,color: Colors.amber,),
                      ],
                    )),
                height16(),
                const GetArticleSlider(),
                height16(),
              ],
            ),
          ),
        ));
  }

  SizedBox height16() => const SizedBox(height: 16);

  Padding customTopWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Row(
        children: [
          const CustomSearchBar(),
          const SizedBox(width: 12),
          settingsIcon(),
          const SizedBox(width: 12),
          timeIcon()
        ],
      ),
    );
  }

  IconButton timeIcon() {
    return IconButton(
      icon: const Icon(
        Icons.timelapse_outlined,
        size: 28,
      ),
      onPressed: () {},
    );
  }

  IconButton settingsIcon() {
    return IconButton(
      icon: const Icon(
        Icons.settings,
        size: 28,
      ),
      onPressed: () {},
    );
  }

  OutlineSearchBar outlineSearchBar() {
    return const OutlineSearchBar(
      borderColor: ProjectColors.colorMarigold,
      searchButtonIconColor: ProjectColors.colorMarigold,
      cursorColor: ProjectColors.colorWhite,
      cursorHeight: 24,
      cursorWidth: 1.5,
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: SizedBox(
        height: 50,
        width: 25,
        child: TextField(
          showCursor: false,
          cursorColor: ProjectColors.colorWhite,
          decoration: InputDecoration(
            hintStyle: ProjectTextStyle.italicTextStyle,
            hintText: 'Haber ara ..',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ProjectColors.colorMarigold),
                borderRadius: BorderRadius.all(Radius.circular(36.0))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ProjectColors.colorMarigold),
                borderRadius: BorderRadius.all(Radius.circular(36.0))),
            prefixIcon: Icon(
              Icons.search,
              color: ProjectColors.colorMarigold,
              size: 28,
            ),
            suffixIcon: Icon(
              Icons.keyboard_voice_outlined,
              color: ProjectColors.colorMarigold,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
