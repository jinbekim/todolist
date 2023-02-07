import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:todolist/domain/core/errors.dart';
import 'package:todolist/infrastructure/auth/firebase_auth_facade.dart';

extension FirestoreX on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final user = await Get.find<FirebaseAuthFacade>().getSignedInUser();
    final userDoc = user.getOrElse(() => throw NotAuthenticatedError());
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userDoc.id.getOrCrash());
  }
}

extension DocumentReferenceX on DocumentReference {
  CollectionReference get noteCollection => collection('notes');
}
