import 'package:cloud_firestore/cloud_firestore.dart';
import 'cloud_storage_constants.dart';
import 'package:flutter/widgets.dart';

@immutable
class CloudNote {
  final String documentId;
  final String owneruserId;
  final String text;

  CloudNote({
    required this.documentId,
    required this.owneruserId,
    required this.text,
  });

  CloudNote.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
    : documentId = snapshot.id,
      owneruserId = snapshot.data()[ownerUserIdFieldName],
      text = snapshot.data()[TextFielName] as String;
}
