import 'package:flutter/material.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/screens/home/web3_browser/storage.dart';

import '../../../component/texts/SmallText.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({super.key});

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  List<dynamic> bookmarks = [];

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  _loadBookmarks() async {
    bookmarks = (await Storage.readData('bookmarks') ?? []).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          const Spacer(),
          bookmarks.isEmpty
              ? Center(
                  child: SmallText(
                    text: 'Your bookmarks will show up here',
                    color: w60_text_color,
                    weight: FontWeight.normal,
                    align: TextAlign.center,
                  )
          )
              : const SizedBox.shrink(),
          const Spacer(),
        ],
      );
    });
  }
}
