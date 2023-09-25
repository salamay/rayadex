// ignore_for_file: unnecessary_null_comparison

import 'dart:typed_data';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/texts/MediumText.dart';
import 'package:ryipay/screens/home/web3_browser/storage.dart';


class Histories extends StatefulWidget {
  const Histories({super.key});

  @override
  State<Histories> createState() => _HistoriesState();
}

class _HistoriesState extends State<Histories> {
  List<dynamic> history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  _loadHistory() async {
    history = (await Storage.readData('history') ?? []).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          //const Spacer(),
          Expanded(
            child: history.isEmpty
                ? Center(
                    child: MediumText(
                      text: "Your history will show up here",
                      color: Colors.white,
                      weight: FontWeight.normal,
                      align: TextAlign.start,
                      maxLines: 2,
                    ))
                : RefreshIndicator(
                    onRefresh: () async => _loadHistory(),
                    child: ListView.builder(
                        itemCount: history.length,
                        itemBuilder: (context, index) {
                          return HistoryItem(historyURL: history[index]);
                        }),
                  ),
          ),
          // const Spacer(),
        ],
      );
    });
  }
}

class HistoryItem extends StatefulWidget {
  final String historyURL;
  const HistoryItem({super.key, required this.historyURL});

  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  String? pageTitle;
  Uint8List? favicon;
  Uri? baseUri;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: AnyLinkPreview(
        link: widget.historyURL,
        boxShadow: const [],
        backgroundColor: w60_text_color,
      ),
    );
    
  }
}
