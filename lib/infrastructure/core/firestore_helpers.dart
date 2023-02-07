import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:todolist/domain/auth/i_auth_facade.dart';
import 'package:todolist/domain/core/errors.dart';

extension FirestoreX on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final user = await Get.find<IAuthFacade>().getSignedInUser();
    final userDoc = user.getOrElse(() => throw NotAuthenticatedError());
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userDoc.id.getOrCrash());
  }
}

extension DocumentReferenceX on DocumentReference {
  CollectionReference get noteCollection => collection('notes');
}
