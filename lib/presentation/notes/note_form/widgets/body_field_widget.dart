import 'package:flutter/material.dart';
import 'package:todolist/application/notes/form/note_form_controller.dart';
import 'package:todolist/domain/notes/value_objects.dart';

class BodyField extends StatelessWidget {
  const BodyField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        initialValue: NoteFormController.to.state.value.note.body.getOrCrash(),
        decoration: const InputDecoration(
          labelText: 'Note',
          counterText: '',
        ),
        maxLength: NoteBody.maxLength,
        maxLines: null,
        minLines: 5,
        onChanged: (val) => NoteFormController.to.bodyChanged(val),
        validator: (_) =>
            NoteFormController.to.state.value.note.body.value.fold(
          (f) => f.maybeMap(
            empty: (_) => 'Cannot be empty',
            exceedingLength: (_) =>
                'Exceeding length, max: ${NoteBody.maxLength}',
            orElse: () => null,
          ),
          (_) => null,
        ),
      ),
    );
  }
}
