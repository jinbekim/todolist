import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';
import 'package:todolist/domain/core/value_objects.dart';
import 'package:todolist/domain/notes/todo_item.dart';
import 'package:todolist/domain/notes/value_objects.dart';

part 'todo_item_presentation_classes.freezed.dart';

class FormTodos extends ValueNotifier<KtList<TodoItemPrimitive>> {
  FormTodos(KtList<TodoItemPrimitive>? value) : super(value ?? emptyList());

  void add(TodoItemPrimitive todoItem) {
    value = value.plusElement(todoItem);
  }

  void remove(TodoItemPrimitive todoItem) {
    value = value.minusElement(todoItem);
  }
}

@freezed
abstract class TodoItemPrimitive implements _$TodoItemPrimitive {
  const factory TodoItemPrimitive({
    required UniqueId id,
    required String name,
    required bool done,
  }) = _TodoItemPrimitive;

  const TodoItemPrimitive._();

  factory TodoItemPrimitive.empty() => TodoItemPrimitive(
        id: UniqueId(),
        name: '',
        done: false,
      );

  factory TodoItemPrimitive.fromDomain(TodoItem todoItem) {
    return TodoItemPrimitive(
      id: todoItem.id,
      name: todoItem.name.getOrCrash(),
      done: todoItem.done,
    );
  }

  TodoItem toDomain() {
    return TodoItem(
      id: id,
      name: TodoName(name),
      done: done,
    );
  }
}
