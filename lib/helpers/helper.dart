import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

Future<Iterable<Reference>> getImages(String userId) => FirebaseStorage.instance
    .ref(userId)
    .list()
    .then((listResult) => listResult.items);

Future<bool> uploadImage({required File file, required String userId}) =>
    FirebaseStorage.instance
        .ref(userId)
        .child(const Uuid().v4())
        .putFile(file)
        .then((p0) => true)
        .catchError((_) => false);
