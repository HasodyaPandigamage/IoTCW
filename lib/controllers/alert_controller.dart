import 'package:flutter/material.dart';
import '../models/alert_model.dart';
import '../services/firebase_service.dart';

class AlertController with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  Alert? _latestAlert;

  Alert? get latestAlert => _latestAlert;

  AlertController() {
    // CORRECTED: The call no longer passes the user ID.
    _firebaseService.getAlertStream().listen((alert) {
      _latestAlert = alert;
      notifyListeners();
    });
  }

  void sendSosAlert() {
    final newAlert = Alert(
      message: 'SOS button pressed!',
      isCritical: true,
      timestamp: DateTime.now(),
    );
    // CORRECTED: The call no longer passes the user ID.
    _firebaseService.addAlert(newAlert);
  }
}