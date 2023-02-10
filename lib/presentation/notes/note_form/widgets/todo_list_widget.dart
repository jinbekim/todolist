import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:implicitly_animated_reorderable_list_2/implicitly_animated_reorderable_list_2.dart';
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
      builder: (context, formTodos, child) {
        return ImplicitlyAnimatedReorderableList<TodoItemPrimitive>(
          shrinkWrap: true,
          items: formTodos.value.asList(),
          areItemsTheSame: (oldItem, newItem) => oldItem.id == newItem.id,
          onReorderFinished: (item, from, to, newItems) {
            context.formTodos = newItems.toImmutableList();
            NoteFormController.to.todosChanged(context.formTodos);
          },
          itemBuilder: (context, itemAnimation, item, index) {
            return Reorderable(
              key: ValueKey(item.id),
              builder: (context, dragAnimation, inDrag) {
                return ScaleTransition(
                  scale:
                      Tween<double>(begin: 1, end: 0.95).animate(dragAnimation),
                  child: TodoTile(
                    index: index,
                    elevation: dragAnimation.value * 4,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class TodoTile extends StatelessWidget {
  final int index;
  final double elevation;
  final bool enabled;

  const TodoTile({
    required this.index,
    this.elevation = 0,
    this.enabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final todo =
        context.formTodos.getOrElse(index, (_) => TodoItemPrimitive.empty());

    return Slidable(
      enabled: enabled,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        child: Material(
          elevation: elevation,
          animationDuration: const Duration(milliseconds: 50),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
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
              trailing: const Handle(
                child: Icon(Icons.list),
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
                    (listTodo) => listTodo == todo
                        ? todo.copyWith(name: value)
                        : listTodo,
                  );
                  NoteFormController.to.todosChanged(context.formTodos);
                },
                validator: (_) {
                  return NoteFormController.to.state.value.note.todos.value
                      .fold(
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
        ),
      ),
    );
  }
}
