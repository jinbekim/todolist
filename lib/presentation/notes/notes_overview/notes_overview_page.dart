import 'package:flutter/material.dart';
import 'package:todolist/application/auth/auth_controller.dart';
import 'package:todolist/presentation/notes/notes_overview/widgets/notes_overview_body_widget.dart';

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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.indeterminate_check_box),
            onPressed: () {},
          ),
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
