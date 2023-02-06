import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todolist/domain/core/value_objects.dart';

part 'user.freezed.dart';

@freezed
abstract class TUser with _$TUser {
  const factory TUser({
    required UniqueId id,
  }) = _TUser;
}
