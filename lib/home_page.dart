
import 'package:flutter/material.dart';
import 'package:news_app/constants/colors.dart';
import 'package:news_app/constants/text_styles.dart';
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
        appBar: AppBar(
          title: const Text(
            'Lightning News',
            style: ProjectTextStyle.titleTextStyle,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              outlineSearchBar(),
              const SizedBox(height: 16),
            ],
          ),
        ));
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