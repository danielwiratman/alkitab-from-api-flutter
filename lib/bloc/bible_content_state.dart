part of 'bible_content_bloc.dart';

@immutable
abstract class BibleContentState extends Equatable {}

class BibleContentInitial extends BibleContentState {
  @override
  List<Object?> get props => [];
}

class BibleContentLoaded extends BibleContentState {
  BibleContentLoaded(this.verses);
  final BibleVerses verses;
  @override
  List<Object?> get props => [];
}

class BibleContentLoading extends BibleContentState {
  @override
  List<Object?> get props => [];
}
