// lib/models/medicine_model.dart

class Medicine {
  final String id;
  final String name;
  final String dosageTime;
  final bool taken;

  Medicine({
    required this.id,
    required this.name,
    required this.dosageTime,
    this.taken = false,
  });

  // This factory is now more robust and can handle bad data.
  factory Medicine.fromRTDB(String key, Map<dynamic, dynamic> data) {
    // Check if 'taken' is a boolean. If not, default to false.
    bool isTaken = false;
    if (data['taken'] is bool) {
      isTaken = data['taken'];
    }

    return Medicine(
      id: key,
      name: data['name'] ?? '',
      dosageTime: data['dosageTimes']?.toString() ?? '',
      taken: isTaken,
    );
  }

  // Converts the object to a map for saving to the database
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dosageTimes': dosageTime,
      'taken': taken,
    };
  }
}
