import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_bible/models/api_models.dart';
import 'package:my_bible/models/api_service.dart';

part 'bible_content_event.dart';
part 'bible_content_state.dart';

class BibleContentBloc extends Bloc<BibleContentEvent, BibleContentState> {
  BibleContentBloc() : super(BibleContentInitial()) {
    on<LoadApiEvent>((event, emit) async {
      emit(BibleContentLoading());
      final verses = await BibleService.getBibleVerses('Kej', 1);
      emit(BibleContentLoaded(verses));
    });
    on<ChangePassageEvent>((event, emit) async {
      emit(BibleContentLoading());
      final verses =
          await BibleService.getBibleVerses(event.book, event.chapter);
      emit(BibleContentLoaded(verses));
    });
  }
}
