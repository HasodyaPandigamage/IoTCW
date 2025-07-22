import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/heart_rate_model.dart';
import '../models/medicine_model.dart';
import '../models/alert_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseDatabase _rtdb = FirebaseDatabase.instance;
  final String _userId = "123456789";

  // --- Heart Rate ---
  Stream<HeartRate> getHeartRateStream() {
    // This is the correct path for your database structure
    DatabaseReference heartRateRef = _rtdb.ref('users/${_userId}/heart rate');
    return heartRateRef.onValue.map((event) {
      if (event.snapshot.exists && event.snapshot.value != null) {
        final data = Map<dynamic, dynamic>.from(event.snapshot.value as Map);
        return HeartRate.fromRTDB(data);
      } else {
        return HeartRate(value: 0);
      }
    });
  }

  // --- Medicines ---
  Stream<List<Medicine>> getMedicineStream() {
    DatabaseReference medicinesRef = _rtdb.ref('users/${_userId}/medicines');
    return medicinesRef.onValue.map((event) {
      final List<Medicine> medicines = [];
      if (event.snapshot.exists && event.snapshot.value != null) {
        final data = Map<String, dynamic>.from(event.snapshot.value as Map);
        data.forEach((key, value) {
          medicines.add(Medicine.fromRTDB(key, value));
        });
        medicines.sort((a, b) => a.id.compareTo(b.id));
      }
      return medicines;
    });
  }

  // This function writes data to a specific slot (e.g., "med 1")
  Future<void> setMedicineInSlot(String slotId, Medicine medicine) {
    DatabaseReference slotRef = _rtdb.ref('users/${_userId}/medicines/$slotId');
    return slotRef.set(medicine.toMap());
  }

  // This function deletes a specific slot from the database
  Future<void> deleteMedicine(String medicineId) {
    DatabaseReference medicineRef = _rtdb.ref('users/${_userId}/medicines/$medicineId');
    return medicineRef.remove();
  }

  // --- Alerts (from Cloud Firestore) ---
  Stream<Alert?> getAlertStream() {
    return _firestore
        .collection('users')
        .doc(_userId)
        .collection('alerts')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return Alert.fromMap(snapshot.docs.first.data());
      }
      return null;
    });
  }

  Future<void> addAlert(Alert alert) {
    return _firestore
        .collection('users')
        .doc(_userId)
        .collection('alerts')
        .add(alert.toMap());
  }
}
