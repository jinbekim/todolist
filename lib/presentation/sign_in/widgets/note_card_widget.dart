import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kt_dart/kt.dart';
import 'package:todolist/application/notes/actor/note_actor_controller.dart';
import 'package:todolist/application/notes/form/note_form_controller.dart';
import 'package:todolist/domain/notes/note.dart';
import 'package:todolist/domain/notes/todo_item.dart';
import 'package:todolist/presentation/routes/get_pages.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: note.color.getOrCrash(),
      child: InkWell(
        onTap: () {
          NoteFormController.to.init(optionOf(note));
          Get.toNamed(Routes.noteFormPage);
        },
        onLongPress: () {
          _showDeletionDialog(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                note.body.getOrCrash(),
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              if (note.todos.length > 0) ...[
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  children: <Widget>[
                    ...note.todos
                        .getOrCrash()
                        .map(
                          (todoItem) => TodoDisplay(
                            todo: todoItem,
                          ),
                        )
                        .iter,
                  ],
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  void _showDeletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selected Note'),
          content: const Text('Do you want to delete this note?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                NoteActorController.to.delete(note);
                Get.back();
              },
              child: const Text('DELETE'),
            ),
          ],
        );
      },
    );
  }
}

class TodoDisplay extends StatelessWidget {
  final TodoItem todo;

  const TodoDisplay({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (todo.done)
          Icon(
            Icons.check_box,
            color: Theme.of(context).colorScheme.secondary,
          ),
        if (!todo.done)
          Icon(
            Icons.check_box_outline_blank,
            color: Theme.of(context).disabledColor,
          ),
        Text(todo.name.getOrCrash()),
      ],
    );
  }
}
