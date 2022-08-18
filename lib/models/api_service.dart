import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_bible/models/api_models.dart';

class BibleService {
  static Future<BibleVerses> getBibleVerses(String book, int chapter) async {
    final response = await get(
      Uri.parse(
          'https://api-alkitab.herokuapp.com/v3/passage/$book/$chapter?ver=tb'),
    );
    final verses = BibleVerses.fromJson(json.decode(response.body));
    return verses;
  }

  static Future<int> getMaxChapters(String book) async {
    final response = await get(
      Uri.parse('https://api-alkitab.herokuapp.com/v2/passage/list'),
    );
    final passageList = BiblePassageList.fromJson(json.decode(response.body));
    return passageList.passageList
        .where((element) => element.bookName == book)
        .toList()
        .first
        .totalChapter;
  }

  static Future<int> getMaxVerses(String book, int chapter) async {
    final response = await get(
      Uri.parse(
          'https://api-alkitab.herokuapp.com/v3/passage/$book/$chapter?ver=tb'),
    );
    final verses = BibleVerses.fromJson(json.decode(response.body));
    print("VERSES: ${verses.verses.length}");
    return verses.verses.length;
  }
}
