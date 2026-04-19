import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getMessages() {
    return _db
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    await _db.collection('messages').add({
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
