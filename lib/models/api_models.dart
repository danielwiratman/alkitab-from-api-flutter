class BibleVerses {
  BibleVerses({
    required this.title,
    required this.bookNumber,
    required this.chapter,
    required this.verses,
  });
  late final String title;
  late final int bookNumber;
  late final int chapter;
  late final List<Verses> verses;
  
  BibleVerses.fromJson(Map<String, dynamic> json){
    title = json['title'];
    bookNumber = json['book_number'];
    chapter = json['chapter'];
    verses = List.from(json['verses']).map((e)=>Verses.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['book_number'] = bookNumber;
    data['chapter'] = chapter;
    data['verses'] = verses.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Verses {
  Verses({
    required this.verse,
    required this.type,
    required this.content,
  });
  late final int verse;
  late final String type;
  late final String content;
  
  Verses.fromJson(Map<String, dynamic> json){
    verse = json['verse'];
    type = json['type'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['verse'] = verse;
    data['type'] = type;
    data['content'] = content;
    return data;
  }
}

class BiblePassageList {
  BiblePassageList({
    required this.passageList,
  });
  late final List<PassageList> passageList;
  
  BiblePassageList.fromJson(Map<String, dynamic> json){
    passageList = List.from(json['passage_list']).map((e)=>PassageList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['passage_list'] = passageList.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class PassageList {
  PassageList({
    required this.bookNumber,
    required this.abbreviation,
    required this.bookName,
    required this.totalChapter,
  });
  late final int bookNumber;
  late final String abbreviation;
  late final String bookName;
  late final int totalChapter;
  
  PassageList.fromJson(Map<String, dynamic> json){
    bookNumber = json['book_number'];
    abbreviation = json['abbreviation'];
    bookName = json['book_name'];
    totalChapter = json['total_chapter'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['book_number'] = bookNumber;
    _data['abbreviation'] = abbreviation;
    _data['book_name'] = bookName;
    _data['total_chapter'] = totalChapter;
    return _data;
  }
}