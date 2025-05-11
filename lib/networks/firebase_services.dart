import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app/helpers/custom_snackbar.dart';

class FirebaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> createUser({
    required String userId,
    required Map<String, dynamic> userData,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).set(userData);
    } catch (e) {
      CustomSnackbar.error(title: "Error ", message: e.toString());
    }
  }
}
