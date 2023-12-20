import 'package:chater/app/modules/one_to_one_chat/domain/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String message,
  }) async {
    print(receiverId);
    print(senderId);
    print(message);
    try {
      await _firestore.collection('messages').add({
        'senderId': senderId,
        'receiverId': receiverId,
        'message': message,
        'timestamp': DateTime.now(),
      });
    } catch (e) {
      throw ('Error sending message: $e');
    }
  }

  Stream<List<Message>> messagesStream({
    required String senderId,
    required String receiverId,
  }) {
    try {
      return _firestore
          .collection('messages')
          .where('senderId', isEqualTo: senderId)
          .where('receiverId', isEqualTo: receiverId)
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs.map((doc) {
                final data = doc.data();
                final timestamp =
                    data['timestamp'] as Timestamp?; // Allow for null

                if (timestamp == null) {
                  throw ('Missing timestamp in message: ${doc.id}');
                }

                return Message(
                  messageId: doc.id,
                  senderId: data['senderId'],
                  receiverId: data['receiverId'],
                  message: data['message'],
                  timestamp: timestamp.toDate(),
                );
              }).toList());
    } catch (e) {
      throw ('Error fetching messages: $e');
    }
  }
}
