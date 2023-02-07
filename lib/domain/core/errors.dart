import 'package:todolist/domain/core/failures.dart';

class NotAuthenticatedError extends Error {}

class UnexpectedValueError extends Error {
  final ValueFailure failedValue;

  UnexpectedValueError(this.failedValue);

  @override
  String toString() {
    return Error.safeToString(
      'UnexpectedValueError(failedValue: $failedValue)',
    );
  }
}
