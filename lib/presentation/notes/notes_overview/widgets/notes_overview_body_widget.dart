import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:todolist/application/notes/watcher/note_watcher_controller.dart';
import 'package:todolist/presentation/sign_in/widgets/critical_failure_display_widget.dart';
import 'package:todolist/presentation/sign_in/widgets/error_note_card_widget.dart';
import 'package:todolist/presentation/sign_in/widgets/note_card_widget.dart';

class NoteOverviewBody extends StatefulWidget {
  const NoteOverviewBody({super.key});

  @override
  State<NoteOverviewBody> createState() => _NoteOverviewBodyState();
}

class _NoteOverviewBodyState extends State<NoteOverviewBody> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await NoteWatcherController.to.watchAllStarted();
    });
  }

  @override
  Widget build(BuildContext context) {
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
            if (note.failureOption.isSome()) {
              return ErrorNoteCard(
                note: note,
              );
            } else {
              return NoteCard(note: note);
            }
          },
        ),
        loadFailure: (state) {
          return CriticalFailureDisplay(failure: state.noteFailure);
        },
      );
    });
  }
}
