part of 'bible_content_bloc.dart';

@immutable
abstract class BibleContentEvent extends Equatable {}

class LoadApiEvent extends BibleContentEvent {
  @override
  List<Object?> get props => [];
}

class ChangePassageEvent extends BibleContentEvent {
  ChangePassageEvent(
      {required this.book, required this.chapter, required this.verse});
  final String book;
  final int chapter;
  final int verse;

  @override
  List<Object?> get props => [];
}
