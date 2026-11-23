import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/notes_list_bloc/notes_list_bloc.dart';
import '../blocs/notes_list_bloc/notes_list_event.dart';
import '../blocs/notes_list_bloc/notes_list_state.dart';
import '../repositories/notes_repository.dart';
import 'note_form_screen.dart';

class NotesListScreen extends StatelessWidget {
  const NotesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Saya'),
      ),
      body: BlocBuilder<NotesListBloc, NotesListState>(
        builder: (context, state) {
          if (state is NotesListLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NotesListLoaded) {
            if (state.notes.isEmpty) {
              return const Center(
                child: Text('Belum ada catatan. Tekan + untuk membuat catatan.'),
              );
            }

            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.note_alt_outlined),
                    title: Text(note.title),
                    subtitle: Text(
                      note.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NoteFormScreen(note: note),
                        ),
                      );
                      if (context.mounted) {
                        context.read<NotesListBloc>().add(const LoadNotes());
                      }
                    },
                    trailing: IconButton(
                      tooltip: 'Hapus catatan',
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () async {
                        await context
                            .read<NotesRepository>()
                            .deleteNote(note.id!);
                        if (context.mounted) {
                          context.read<NotesListBloc>().add(const LoadNotes());
                        }
                      },
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text('Terjadi kesalahan.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const NoteFormScreen(),
            ),
          );
          if (context.mounted) {
            context.read<NotesListBloc>().add(const LoadNotes());
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
