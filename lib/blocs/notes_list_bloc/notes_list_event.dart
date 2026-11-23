
import 'package:equatable/equatable.dart';

abstract class NotesListEvent extends Equatable {
  const NotesListEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotes extends NotesListEvent {
  const LoadNotes();
}

