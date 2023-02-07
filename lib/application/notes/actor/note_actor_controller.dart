import 'package:get/get.dart';
import 'package:todolist/application/notes/actor/note_actor_state.dart';
import 'package:todolist/domain/notes/i_note_repository.dart';
import 'package:todolist/domain/notes/note.dart';

class NoteActorController extends GetxController {
  final INoteRepository _iNoteRepository;

  static NoteActorController get to => Get.find();

  final Rx<NoteActorState> state = const NoteActorState.initial().obs;

  NoteActorController(this._iNoteRepository);

  @override
  void onInit() {
    super.onInit();
    ever(
      state,
      (_) => {
        state.value.maybeMap(
          deleteFailure: (failure) => Get.snackbar(
            "alert",
            failure.noteFailure.map(
              unexpected: (_) => 'Unexpected error occured',
              insufficientPermission: (_) => 'Insufficient permissions',
              unableToUpdate: (_) => 'Unable to update',
            ),
            duration: const Duration(seconds: 5),
          ),
          orElse: () {},
        )
      },
    );
  }

  Future<void> delete(Note note) async {
    final possibleFailure = await _iNoteRepository.delete(note);
    state.value = possibleFailure.fold(
      (failure) => NoteActorState.deleteFailure(failure),
      (_) => const NoteActorState.deleteSuccess(),
    );
  }
}
