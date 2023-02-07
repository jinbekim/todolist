import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kt_dart/kt.dart';
import 'package:todolist/application/notes/watcher/note_watcher_controller.dart';

class NoteOverviewBody extends StatelessWidget {
  const NoteOverviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    NoteWatcherController.to.watchAllStarted();
    return Obx(() {
      return NoteWatcherController.to.state.value.map(
        initial: (_) => Container(),
        loadInProgress: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
        loadSuccess: (state) => ListView.builder(
          itemCount: state.notes.size,
          itemBuilder: (context, index) {
            final note = state.notes[index];
            return ListTile(
              title: Text(note.body.getOrCrash()),
              trailing: Checkbox(
                value: note.todos.getOrCrash().isNotEmpty(),
                onChanged: (value) {},
              ),
            );
          },
        ),
        loadFailure: (state) {
          return Container();
        },
      );
    });
  }
}
