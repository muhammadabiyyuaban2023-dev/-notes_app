import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/note.dart';

class NoteFormCubit extends Cubit<Note> {
  NoteFormCubit()
      : super(Note(
          title: '',
          content: '',
          createdAt: DateTime.now(),
        ));

  void updateTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void updateContent(String content) {
    emit(state.copyWith(content: content));
  }

  void reset() {
    emit(Note(
      title: '',
      content: '',
      createdAt: DateTime.now(),
    ));
  }
}
