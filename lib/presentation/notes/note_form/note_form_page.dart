import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/application/notes/form/note_form_controller.dart';
import 'package:todolist/domain/notes/note.dart';
import 'package:todolist/presentation/notes/note_form/widgets/body_field_widget.dart';

class NoteFormPage extends StatelessWidget {
  final Note? editedNote;

  NoteFormPage({super.key, required this.editedNote}) {
    NoteFormController.to.init(optionOf(editedNote));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const NoteFormPageScaffold(),
        Obx(
          () => SavingInProgressOverlay(
            isSaving: NoteFormController.to.state.value.isSaving,
          ),
        )
      ],
    );
  }
}

class SavingInProgressOverlay extends StatelessWidget {
  final bool isSaving;

  const SavingInProgressOverlay({
    super.key,
    required this.isSaving,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        color: isSaving ? Colors.black.withOpacity(0.6) : Colors.transparent,
        width: MediaQuery.of(context).size.width,
        child: Visibility(
          visible: isSaving,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Saving',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoteFormPageScaffold extends StatelessWidget {
  const NoteFormPageScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: NoteFormController.to.state.value.isEditing
            ? const Text('Edit a note')
            : const Text('Create a note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              NoteFormController.to.saved();
            },
          ),
        ],
      ),
      body: Obx(
        () => Form(
          autovalidateMode: NoteFormController.to.state.value.showErrorMessages
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: SingleChildScrollView(
            child: Column(
              children: const [
                BodyField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
