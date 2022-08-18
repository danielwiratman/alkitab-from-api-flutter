import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bible/bloc/bible_content_bloc.dart';
import 'package:my_bible/models/api_service.dart';
import 'package:my_bible/pages/alkitab_page.dart';
import 'package:my_bible/pages/choose_verse_page.dart';

import 'pages/renungan_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BibleContentBloc(),
          )
        ],
        child: MaterialApp(
          title: "Flutter Bible",
          darkTheme: ThemeData(colorScheme: const ColorScheme.dark()),
          themeMode: ThemeMode.dark,
          initialRoute: '/',
          routes: {
            '/': (context) => const AlkitabPage(),
            '/renungan': (context) => const RenunganPage(),
            '/chooseVerse': (context) => const ChooseVersePage(),
          },
        ),
      );
    });
  }
}
