import 'dart:ui';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:kt_dart/kt.dart';
import 'package:todolist/application/notes/form/note_form_state.dart';
import 'package:todolist/domain/notes/i_note_repository.dart';
import 'package:todolist/domain/notes/note.dart';
import 'package:todolist/domain/notes/note_failure.dart';
import 'package:todolist/domain/notes/value_objects.dart';
import 'package:todolist/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';
import 'package:todolist/presentation/routes/get_pages.dart';

class NoteFormController extends GetxController {
  final INoteRepository _noteRepository;

  final Rx<NoteFormState> state = NoteFormState.initial().obs;

  NoteFormController(this._noteRepository);

  static NoteFormController get to => Get.find();

  @override
  void onReady() {
    super.onReady();
    ever(
      state,
      (_) => state.value.saveFailureOrSuccessOption.fold(
        () => {},
        (either) => either.fold(
          (failure) {
            Get.snackbar(
              "NoteForm",
              failure.map(
                unexpected: (_) => "Unexpected error occured",
                insufficientPermission: (_) => "Insufficient permissions",
                unableToUpdate: (_) => "Unable to update",
              ),
            );
          },
          (_) => Get.until(
            (route) => route.settings.name == Routes.noteOverviewPage,
          ),
        ),
      ),
      condition: () => state.value.saveFailureOrSuccessOption.isSome(),
    );
  }

  void init(Option<Note> initialNoteOption) {
    state.value = initialNoteOption.fold(
      () => NoteFormState.initial(),
      (initialNote) => state.value.copyWith(
        note: initialNote,
        isEditing: true,
        saveFailureOrSuccessOption: none(),
      ),
    );
  }

  void bodyChanged(String bodyStr) {
    state.value = state.value.copyWith(
      note: state.value.note.copyWith(
        body: NoteBody(bodyStr),
      ),
      saveFailureOrSuccessOption: none(),
    );
  }

  void colorChanged(Color color) {
    state.value = state.value.copyWith(
      note: state.value.note.copyWith(
        color: NoteColor(color),
      ),
      saveFailureOrSuccessOption: none(),
    );
  }

  void todosChanged(KtList<TodoItemPrimitive> todos) {
    state.value = state.value.copyWith(
      note: state.value.note.copyWith(
        todos: List3(todos.map((primitive) => primitive.toDomain())),
      ),
      saveFailureOrSuccessOption: none(),
    );
  }

  Future<void> saved() async {
    Either<NoteFailure, Unit>? failureOrSuccess;

    state.value = state.value.copyWith(
      isSaving: true,
      saveFailureOrSuccessOption: none(),
    );

    if (state.value.note.failureOption.isNone()) {
      failureOrSuccess = state.value.isEditing
          ? await _noteRepository.update(state.value.note)
          : await _noteRepository.create(state.value.note);
    }

    state.value = state.value.copyWith(
      isSaving: false,
      showErrorMessages: true,
      saveFailureOrSuccessOption: optionOf(failureOrSuccess),
    );
  }
}
