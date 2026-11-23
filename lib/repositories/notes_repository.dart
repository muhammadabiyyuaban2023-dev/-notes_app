import 'package:hive/hive.dart';

import '../models/note.dart';

class NotesRepository {
  final Box notesBox;

  NotesRepository(this.notesBox);

  Future<void> saveNote(Note note) async {
    if (note.id == null) {
      final id = await notesBox.add(note.toMap());
      await notesBox.put(id, note.copyWith(id: id).toMap());
    } else {
      await notesBox.put(note.id, note.toMap());
    }
  }

  List<Note> getAllNotes() {
    final notes = notesBox.values
        .map((value) => Note.fromMap(value as Map))
        .toList();

    notes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return notes;
  }

  Future<void> deleteNote(int id) async {
    await notesBox.delete(id);
  }
}
