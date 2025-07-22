import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/heart_rate_controller.dart';
import 'package:firebase_database/firebase_database.dart'; // We need this for the direct connection

class HeartRateCard extends StatelessWidget {
  const HeartRateCard({super.key});

  @override
  Widget build(BuildContext context) {
    // This line gets the controller that is receiving the live data.
    final heartRateController = Provider.of<HeartRateController>(context);

    // This line gets the value from the controller. If the controller hasn't
    // received data yet, it shows "..." as a placeholder.
    final heartRate = heartRateController.latestHeartRate?.value ?? '...';

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Watch Status", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.favorite, color: Colors.red, size: 28),
                const SizedBox(width: 8),
                Text(
                  "$heartRate bpm",
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
