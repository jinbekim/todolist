import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kt_dart/kt.dart';
import 'package:todolist/application/notes/form/note_form_controller.dart';
import 'package:todolist/presentation/notes/note_form/misc/build_context_x.dart';
import 'package:todolist/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';

class AddTodoTile extends StatelessWidget {
  const AddTodoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        enabled: !NoteFormController.to.state.value.note.todos.isFull,
        title: const Text('Add a todo'),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.add),
        ),
        onTap: () {
          context.formTodos =
              context.formTodos.plusElement(TodoItemPrimitive.empty());
          NoteFormController.to.todosChanged(
            context.formTodos,
          );
        },
      ),
    );
  }
}
