import 'package:firebase_auth/firebase_auth.dart';
import 'package:todolist/domain/auth/user.dart';
import 'package:todolist/domain/core/value_objects.dart';

extension FirebaseUserDomainX on User {
  TUser toDomain() {
    return TUser(
      id: UniqueId.fromUniqueString(uid),
    );
  }
}
