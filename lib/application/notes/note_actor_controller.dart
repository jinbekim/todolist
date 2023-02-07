import 'package:get/get.dart';
import 'package:todolist/application/notes/note_actor_state.dart';
import 'package:todolist/domain/notes/i_note_repository.dart';
import 'package:todolist/domain/notes/note.dart';

class NoteActorController {
  final INoteRepository _iNoteRepository;

  final Rx<NoteActorState> state = const NoteActorState.initial().obs;

  NoteActorController(this._iNoteRepository);

  Future<void> delete(Note note) async {
    final possibleFailure = await _iNoteRepository.delete(note);
    state.value = possibleFailure.fold(
      (failure) => NoteActorState.deleteFailure(failure),
      (_) => const NoteActorState.deleteSuccess(),
    );
  }
}
