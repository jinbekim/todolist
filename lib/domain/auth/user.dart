import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todolist/domain/core/value_objects.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$TUser {
  const factory User({
    required UniqueId id,
  }) = _TUser;
}
