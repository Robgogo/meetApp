import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meet_app/screens/contact/contact.dart';
import 'package:meet_app/services/auth_service.dart';

class ContactService {
  User user = AuthService().getCurrentUser();

  get users => FirebaseFirestore.instance.collection('contact').doc(user.uid).collection('contacts').withConverter<Contact>(
            fromFirestore: (snapshot, _) => Contact.fromJson(snapshot.data()),
            toFirestore: (user, _) => user.toJson(),
          );
}
