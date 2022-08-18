import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bible_content_bloc.dart';

class AlkitabPage extends StatefulWidget {
  const AlkitabPage({Key? key}) : super(key: key);

  @override
  State<AlkitabPage> createState() => _AlkitabPageState();
}

class _AlkitabPageState extends State<AlkitabPage> {
  Color dropdownColor = Colors.white;
  String contentTitle = "Kejadian 1";

  @override
  void initState() {
    BlocProvider.of<BibleContentBloc>(context).add(LoadApiEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return BlocBuilder<BibleContentBloc, BibleContentState>(
      builder: (context, state) {
        if (state is BibleContentLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is BibleContentLoaded) {
          return ListView(
            padding: const EdgeInsets.only(bottom: 12.0, right: 16, left: 16),
            children: state.verses.verses.map((e) {
              if (e.type == 'title') {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 4.0, top: 16),
                    child: Text(
                      e.content,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: RichText(
                  text:
                      TextSpan(style: const TextStyle(fontSize: 16), children: [
                    TextSpan(
                        text: e.verse.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: " ${e.content}"),
                  ]),
                ),
              );
            }).toList(),
          );
        }
        return Container();
      },
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).viewPadding.top,
        ),
        child: Column(
          children: [
            buildDrawerListTile(context, Icons.book, "Alkitab"),
            buildDrawerListTile(
                context, Icons.stay_primary_portrait, "Renungan"),
            buildDrawerListTile(context, Icons.music_note, "Kidung"),
            buildDrawerListTile(context, Icons.settings, "Pengaturan"),
            buildDrawerListTile(context, Icons.help, "Bantuan"),
          ],
        ),
      ),
    );
  }

  ListTile buildDrawerListTile(
      BuildContext context, IconData icon, String text) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  AppBar buildAppBar() => AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.chevron_left),
              splashRadius: 20,
            ),
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(9999),
                onTap: () {
                  Navigator.pushNamed(context, '/chooseVerse');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocBuilder<BibleContentBloc, BibleContentState>(
                    builder: (context, state) {
                      if (state is BibleContentLoading) {
                        return Text("Loading...");
                      }
                      if (state is BibleContentLoaded) {
                        return FittedBox(
                          child: Text(
                            "${state.verses.title}",
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.chevron_right),
              splashRadius: 20,
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTapDown: (e) {
                  setState(() {
                    dropdownColor = Colors.blue;
                  });
                },
                onTapUp: (e) {
                  setState(() {
                    dropdownColor = Colors.white;
                  });
                },
                child: Row(
                  children: [
                    const Text(
                      "TB",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: dropdownColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            splashRadius: 20,
          )
        ],
      );
}
