import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/alert_controller.dart';

class AlertCard extends StatelessWidget {
  const AlertCard({super.key});

  @override
  Widget build(BuildContext context) {
    final alertController = Provider.of<AlertController>(context);
    final isCritical = alertController.latestAlert?.isCritical ?? false;
    final message = alertController.latestAlert?.message ?? 'All Clear';

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Alert", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Icon(
              isCritical ? Icons.warning : Icons.check_circle,
              color: isCritical ? Colors.red : Colors.green,
              size: 40,
            ),
            const SizedBox(height: 4),
            Text(message, textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}