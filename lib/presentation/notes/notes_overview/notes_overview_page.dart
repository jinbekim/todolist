import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/application/auth/auth_controller.dart';
import 'package:todolist/application/notes/form/note_form_controller.dart';
import 'package:todolist/presentation/notes/notes_overview/widgets/notes_overview_body_widget.dart';
import 'package:todolist/presentation/notes/notes_overview/widgets/uncompleted_switch.dart';
import 'package:todolist/presentation/routes/get_pages.dart';

class NoteOverviewPage extends StatelessWidget {
  const NoteOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {
            AuthController.to.signOut();
          },
        ),
        actions: const <Widget>[
          UncompletedSwitch(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // NOTE
          NoteFormController.to.init(optionOf(null));
          Get.toNamed(Routes.noteFormPage);
        },
        child: const Icon(Icons.add),
      ),
      body: const NoteOverviewBody(),
    );
  }
}
