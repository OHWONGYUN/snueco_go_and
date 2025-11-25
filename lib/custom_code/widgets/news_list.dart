// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;
import 'package:url_launcher/url_launcher.dart';

class NewsList extends StatefulWidget {
  String url = 'https://www.hkbs.co.kr/';

  final double? width;
  final double? height;

  NewsList({super.key, this.height, this.width});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  get url => widget.url;
  get width => widget.width ?? 500;
  get height => widget.height ?? 800;

  List<String>? articleTitles;
  List<String>? articleDiscriptions;
  List<String>? articleLinks;
  List<String?>? articleImageUrls;

  Map<String, String> replaceMap = {
    "<br>\n": "\n",
    "<br>": "\n",
    "&nbsp;": " "
  };

  Widget renderArticle(
      String title, String description, String link, String? imageUrl) {
    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse(link));
      },
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageUrl != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4, right: 8),
                  child: SizedBox(
                    height: 60,
                    child: ClipRect(
                      child: SizedBox(
                        width: 100,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Align(
                              alignment: Alignment.center,
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: Image.network(imageUrl)),
                        ),
                      ),
                    ),
                  ),
                ),
              SizedBox(
                width:
                    min<double>(width, MediaQuery.of(context).size.width) - 124,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    Container(
                      height: 4,
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String replaceByMap(String prev, Map<String, String> map) {
    for (int i = 0; i < map.length; i++) {
      var entry = map.entries.elementAt(i);
      prev = prev.replaceAll(entry.key, entry.value);
    }
    return prev;
  }

  Future<String?> getArticleInfo(String articleUrl) async {
    var response = await http.get(Uri.parse(articleUrl), headers: {
      'accept-encoding': 'gzip,deflate,br',
      'accept-language': 'ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7',
    }).timeout(const Duration(seconds: 2));

    dom.Document document = parse.parse(response.body);

    String? elements =
        document.body?.querySelector("h4[class='subheading']")?.innerHtml;

    if (elements != null) {
      return replaceByMap(elements, replaceMap);
    } else {
      return "";
    }
  }

  Future<String?> getArticleImage(String articleUrl) async {
    var response = await http.get(Uri.parse(articleUrl), headers: {
      'accept-encoding': 'gzip,deflate,br',
      'accept-language': 'ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7',
    }).timeout(const Duration(seconds: 2));

    dom.Document document = parse.parse(response.body);

    String? elements = document.body
        ?.querySelector("article[id='article-view-content-div']")
        ?.querySelector("img")
        ?.attributes['src'];

    return elements;
  }

  Future<void> getData() async {
    var response = await http.get(Uri.parse(url), headers: {
      'accept-encoding': 'gzip,deflate,br',
      'accept-language': 'ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7',
    }).timeout(const Duration(seconds: 2));

    dom.Document document = parse.parse(response.body);

    List<dom.Element>? elements =
        document.body?.querySelector("div[id='skin-11']")?.children;

    List<String> descriptions = [];
    List<String> links = [];
    List<String?> imageUrls = [];

    if (elements != null) {
      for (int i = 0; i < elements!.length; i++) {
        var element = elements[i];
        String link =
            "https://www.hkbs.co.kr/${element.children[0].attributes["href"]}";
        //print("https://www.hkbs.co.kr/${element.children[0].attributes["href"]}");
        String? res = await getArticleInfo(link);
        String? imgUrl = await getArticleImage(link);

        if (res != null) {
          descriptions.add(res!);
          links.add(link);
          imageUrls.add(imgUrl);
          //print(res!);
        }
      }
    }

    setState(() {
      articleTitles = [
        ...?elements?.map((element) {
          return element.children[0].innerHtml;
        })
      ];
      articleDiscriptions = descriptions;
      articleLinks = links;
      articleImageUrls = imageUrls;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (articleTitles != null)
              ...List<int>.generate(articleTitles!.length, (i) => i).map((i) {
                return renderArticle(articleTitles![i], articleDiscriptions![i],
                    articleLinks![i], articleImageUrls![i]);
              }),
          ],
        ),
      ),
    );
  }
}
