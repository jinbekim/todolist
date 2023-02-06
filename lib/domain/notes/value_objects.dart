import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';
import 'package:todolist/domain/core/failures.dart';
import 'package:todolist/domain/core/value_objects.dart';
import 'package:todolist/domain/core/value_transformers.dart';
import 'package:todolist/domain/core/value_validators.dart';

class NoteBody extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;
  static const maxLength = 1000;

  factory NoteBody(String input) {
    return NoteBody._(
      validateMaxStringLength(input, maxLength).flatMap(validateStringNotEmpty),
    );
  }

  const NoteBody._(this.value);
}

class TodoName extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;
  static const maxLength = 30;

  factory TodoName(String input) {
    return TodoName._(
      validateMaxStringLength(input, maxLength)
          .flatMap(validateStringNotEmpty)
          .flatMap(validateSingleLine),
    );
  }

  const TodoName._(this.value);
}

class NoteColor extends ValueObject<Color> {
  static const List<Color> predefinedColors = [
    Color(0xFFFAFAFA),
    Color(0xFFFFF3E0),
    Color(0xFFFFEBEE),
    Color(0xFFE8F5E9),
    Color(0xFFE3F2FD),
    Color(0xFFE1F5FE),
    Color(0xFFEDE7F6),
    Color(0xFFFFFDE7),
    Color(0xFFFFF8E1),
    Color(0xFFFCF8E3),
    Color(0xFFF3E5F5),
    Color(0xFFECEFF1),
    Color(0xFFCFD8DC),
  ];

  @override
  final Either<ValueFailure<Color>, Color> value;

  factory NoteColor(Color input) {
    return NoteColor._(right(makeColorOpaque(input)));
  }

  const NoteColor._(this.value);
}

class List3<T> extends ValueObject<KtList<T>> {
  @override
  final Either<ValueFailure<KtList<T>>, KtList<T>> value;
  static const maxLength = 3;

  factory List3(KtList<T> input) {
    return List3._(
      validateMaxListLength(input, maxLength),
    );
  }
  const List3._(this.value);

  int get length {
    return value.getOrElse(() => emptyList()).size;
  }

  bool get isFull {
    return length == maxLength;
  }
}
