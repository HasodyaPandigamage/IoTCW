import 'package:flutter/material.dart';
import '../models/medicine_model.dart';
import '../services/firebase_service.dart';

class MedicineController with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  List<Medicine> _medicines = [];
  List<Medicine> get medicines => _medicines;

  MedicineController() {
    _firebaseService.getMedicineStream().listen((medicines) {
      _medicines = medicines;
      notifyListeners();
    });
  }

  // This is the core logic for adding a medicine to the next available slot
  Future<void> addMedicine(Medicine newMedicine) async {
    // 1. Check if the box is already full
    if (_medicines.length >= 3) {
      return; // Do nothing if all 3 slots are taken
    }

    // 2. Define all possible slots
    const slots = ['med 1', 'med 2', 'med 3'];
    // 3. Get a list of the slots that are currently filled
    final takenSlots = _medicines.map((m) => m.id).toList();

    // 4. Find the first slot name that is NOT in the takenSlots list
    String? nextSlot;
    for (var slot in slots) {
      if (!takenSlots.contains(slot)) {
        nextSlot = slot;
        break; // Stop as soon as we find the first empty one
      }
    }

    // 5. If we found an empty slot, tell the service to save the medicine there
    if (nextSlot != null) {
      await _firebaseService.setMedicineInSlot(nextSlot, newMedicine);
    }
  }

  void deleteMedicine(String medicineId) {
    _firebaseService.deleteMedicine(medicineId);
  }
}