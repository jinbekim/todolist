import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kt_dart/kt.dart';
import 'package:provider/provider.dart';
import 'package:todolist/application/notes/form/note_form_controller.dart';
import 'package:todolist/domain/notes/value_objects.dart';
import 'package:todolist/presentation/notes/note_form/misc/build_context_x.dart';
import 'package:todolist/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FormTodos>(
      builder: (context, formTodos, child) => ListView.builder(
        shrinkWrap: true,
        itemCount: formTodos.value.size,
        itemBuilder: (context, index) {
          return TodoTile(
            index: index,
            key: ValueKey(context.formTodos[index].id),
          );
        },
      ),
    );
  }
}

class TodoTile extends HookWidget {
  final int index;

  const TodoTile({
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final todo =
        context.formTodos.getOrElse(index, (_) => TodoItemPrimitive.empty());
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.15,
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            label: 'Delete',
            padding: const EdgeInsets.symmetric(horizontal: 10),
            borderRadius: BorderRadius.circular(5),
            onPressed: (_) {
              context.formTodos = context.formTodos.minusElement(todo);
              NoteFormController.to.todosChanged(context.formTodos);
            },
            icon: Icons.delete,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        child: ListTile(
          leading: Checkbox(
            value: todo.done,
            onChanged: (value) {
              context.formTodos = context.formTodos.map(
                (listTodo) => listTodo == todo
                    ? todo.copyWith(done: value ?? false)
                    : listTodo,
              );
              NoteFormController.to.todosChanged(context.formTodos);
            },
          ),
          title: TextFormField(
            decoration: const InputDecoration(
              counterText: '',
              hintText: 'Todo',
              border: InputBorder.none,
            ),
            maxLength: TodoName.maxLength,
            initialValue: todo.name,
            onChanged: (value) {
              context.formTodos = context.formTodos.map(
                (listTodo) =>
                    listTodo == todo ? todo.copyWith(name: value) : listTodo,
              );
              NoteFormController.to.todosChanged(context.formTodos);
            },
            validator: (_) {
              return NoteFormController.to.state.value.note.todos.value.fold(
                (f) => f.maybeMap(
                  empty: (_) => 'Cannot be empty',
                  exceedingLength: (_) => 'Too long',
                  orElse: () => null,
                ),
                (_) => null,
              );
            },
          ),
        ),
      ),
    );
  }
}
