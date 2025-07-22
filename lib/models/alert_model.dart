class Alert {
  final String message;
  final bool isCritical;
  final DateTime timestamp;

  Alert({required this.message, this.isCritical = false, required this.timestamp});

  factory Alert.fromMap(Map<String, dynamic> data) {
    return Alert(
      message: data['message'] ?? 'Unknown Alert',
      isCritical: data['isCritical'] ?? false,
      timestamp: data['timestamp']?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'isCritical': isCritical,
      'timestamp': timestamp,
    };
  }
}