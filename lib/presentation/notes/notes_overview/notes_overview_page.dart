import 'package:flutter/material.dart';
import 'package:todolist/application/auth/auth_controller.dart';
import 'package:todolist/presentation/notes/notes_overview/widgets/notes_overview_body_widget.dart';
import 'package:todolist/presentation/notes/notes_overview/widgets/uncompleted_switch.dart';

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
          // TODO:
        },
        child: const Icon(Icons.add),
      ),
      body: const NoteOverviewBody(),
    );
  }
}
