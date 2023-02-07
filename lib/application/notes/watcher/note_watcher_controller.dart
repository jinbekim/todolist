import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:kt_dart/kt.dart';
import 'package:todolist/application/notes/watcher/note_watcher_state.dart';
import 'package:todolist/domain/notes/i_note_repository.dart';
import 'package:todolist/domain/notes/note.dart';
import 'package:todolist/domain/notes/note_failure.dart';

class NoteWatcherController extends GetxController {
  final INoteRepository _noteRepository;
  final state = const NoteWatcherState.initial().obs;

  NoteWatcherController(this._noteRepository);

  StreamSubscription<Either<NoteFailure, KtList<Note>>>?
      _noteStreamSubscription;

  static NoteWatcherController get to => Get.find();

  Future<void> watchAllStarted() async {
    state.value = const NoteWatcherState.loadInProgress();
    await _noteStreamSubscription?.cancel();
    _noteStreamSubscription =
        _noteRepository.watchAll().listen((failureOrNotes) {
      notesReceived(failureOrNotes);
    });
  }

  Future<void> watchUncompletedStarted() async {
    state.value = const NoteWatcherState.loadInProgress();
    await _noteStreamSubscription?.cancel();
    _noteStreamSubscription =
        _noteRepository.watchAll().listen((failureOrNotes) {
      notesReceived(failureOrNotes);
    });
  }

  void notesReceived(Either<NoteFailure, KtList<Note>> failureOrNotes) {
    state.value = failureOrNotes.fold(
      (failure) => NoteWatcherState.loadFailure(failure),
      (notes) => NoteWatcherState.loadSuccess(notes),
    );
  }

  Future<void> close() async {
    await _noteStreamSubscription?.cancel();
  }
}
