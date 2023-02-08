import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:todolist/domain/auth/user.dart';
import 'package:todolist/domain/core/value_objects.dart';

extension FirebaseUserDomainX on firebase_auth.User {
  User toDomain() {
    return User(
      id: UniqueId.fromUniqueString(uid),
    );
  }
}
