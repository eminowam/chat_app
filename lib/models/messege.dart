class Messege {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp;

  Messege({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.Timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderIf': senderId,
      'senderEmail': senderEmail,
      "receiverId": receiverId,
      'message': message,
      'Timestamp': Timestamp
    };
  }
}
