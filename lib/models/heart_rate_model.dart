class HeartRate {
  final int value;

  // The timestamp has been removed
  HeartRate({required this.value});

  // Updated factory constructor to only read the value
  factory HeartRate.fromRTDB(Map<dynamic, dynamic> data) {
    return HeartRate(
      value: data['value'] ?? 0,
    );
  }

  // This one is for Firestore, we can simplify it too
  factory HeartRate.fromMap(Map<String, dynamic> data) {
    return HeartRate(
      value: data['value'] ?? 0,
    );
  }
}
