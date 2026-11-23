
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/note.dart';
import '../../repositories/notes_repository.dart';
import 'notes_list_event.dart';
import 'notes_list_state.dart';

class NotesListBloc extends Bloc<NotesListEvent, NotesListState> {
  final NotesRepository notesRepository;

  NotesListBloc(this.notesRepository)
      : super(const NotesListLoading()) {
    on<LoadNotes>((event, emit) {
      final notes = notesRepository.getAllNotes();
      emit(NotesListLoaded(notes));
    });
  }
}

