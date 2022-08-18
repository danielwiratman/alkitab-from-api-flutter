import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bible/bloc/bible_content_bloc.dart';
import 'package:my_bible/models/api_service.dart';

class ChooseVersePage extends StatefulWidget {
  const ChooseVersePage({Key? key}) : super(key: key);

  @override
  State<ChooseVersePage> createState() => _ChooseVersePageState();
}

class _ChooseVersePageState extends State<ChooseVersePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(tabs: [
            Tab(text: "TELUSURI"),
            Tab(text: "KETIK"),
            Tab(text: "PILIH"),
          ]),
        ),
        body: const TabBarView(
          children: [
            TelusuriTab(),
            Text("View 2"),
            Text("View 3"),
          ],
        ),
      ),
    );
  }
}

class TelusuriTab extends StatefulWidget {
  const TelusuriTab({Key? key}) : super(key: key);

  @override
  State<TelusuriTab> createState() => _TelusuriTabState();
}

class _TelusuriTabState extends State<TelusuriTab> {
  List<String> books = [
    'Kejadian',
    'Keluaran',
    'Imamat',
    'Bilangan',
    'Ulangan',
    'Yosua',
    'Hakim-hakim',
    'Rut',
    '1 Samuel',
    '2 Samuel',
    '1 Raja-Raja',
    '2 Raja-Raja',
    '1 Tawarikh',
    '2 Tawarikh',
    'Ezra',
    'Nehemia',
    'Ester',
    'Ayub',
    'Mazmur',
    'Amsal',
    'Pengkhotbah',
    'Kidung Agung',
    'Yesaya',
    'Yeremia',
    'Ratapan',
    'Yehezkiel',
    'Daniel',
    'Hosea',
    'Yoel',
    'Amos',
    'Obaja',
    'Yunus',
    'Mikha',
    'Nahum',
    'Habakuk',
    'Zefanya',
    'Hagai',
    'Zakharia',
    'Maleakhi',
    'Matius',
    'Markus',
    'Lukas',
    'Yohanes',
    'Kisah Para Rasul',
    'Roma',
    '1 Korintus',
    '2 Korintus',
    'Galatia',
    'Efesus',
    'Filipi',
    'Kolose',
    '1 Tesalonika',
    '2 Tesalonika',
    '1 Timotius',
    '2 Timotius',
    'Titus',
    'Filemon',
    'Ibrani',
    'Yakobus',
    '1 Petrus',
    '2 Petrus',
    '1 Yohanes',
    '2 Yohanes',
    '3 Yohanes',
    'Yudas',
    'Wahyu',
  ];

  List<int> chapters = List.generate(60, (index) => index + 1);
  List<int> verses = List.generate(31, (index) => index + 1);

  String selectedBook = "Kejadian";
  int selectedChapter = 1;
  int selectedVerse = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              isExpanded: true,
              style: TextStyle(fontSize: 18),
              value: selectedBook,
              items: books
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (val) async {
                print(val);
                setState(() {
                  selectedBook = val.toString();
                });
                int newMaxChapters =
                    await BibleService.getMaxChapters(val.toString());
                setState(() {
                  chapters =
                      List.generate(newMaxChapters, (index) => index + 1);
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Pasal",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  width: 10,
                ),
                DropdownButton(
                  style: TextStyle(fontSize: 16),
                  value: selectedChapter,
                  items: chapters
                      .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
                      .toList(),
                  onChanged: (val) async {
                    print(val);
                    setState(() {
                      selectedChapter = int.parse(val.toString());
                    });
                    int newMaxVerses = await BibleService.getMaxVerses(
                      selectedBook,
                      int.parse(
                        val.toString(),
                      ),
                    );
                    print(newMaxVerses);
                    setState(() {
                      verses =
                          List.generate(newMaxVerses, (index) => index + 1);
                    });
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Ayat",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  width: 10,
                ),
                DropdownButton(
                  style: TextStyle(fontSize: 16),
                  value: selectedVerse,
                  items: verses
                      .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
                      .toList(),
                  onChanged: (val) {
                    print(val);
                    setState(() {
                      selectedVerse = int.parse(val.toString());
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<BibleContentBloc>(context).add(
                      ChangePassageEvent(
                          book: selectedBook,
                          chapter: selectedChapter,
                          verse: selectedVerse));
                  Navigator.pop(context);
                },
                child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
