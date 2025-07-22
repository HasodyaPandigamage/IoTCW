import 'package:flutter/material.dart';
import '../models/heart_rate_model.dart';
import '../services/firebase_service.dart';

class HeartRateController with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  HeartRate? _latestHeartRate;
  HeartRate? get latestHeartRate => _latestHeartRate;

  HeartRateController() {
    // The call no longer needs the user ID because it's handled in the service.
    _firebaseService.getHeartRateStream().listen((heartRate) {
      _latestHeartRate = heartRate;
      notifyListeners();
    });
  }
}

