import 'package:flutter/material.dart';
import 'widgets/heart_rate_card.dart';
import 'widgets/alert_card.dart';
import 'widgets/medicine_status_card.dart';
import 'widgets/sos_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Care Hub'),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("User ID:\n123456789", textAlign: TextAlign.center),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Row(
              children: [
                Expanded(child: HeartRateCard()),
                SizedBox(width: 12),
                Expanded(child: AlertCard()),
              ],
            ),
            SizedBox(height: 12),
            MedicineStatusCard(),
            SizedBox(height: 12),
            SosButton(),
          ],
        ),
      ),
    );
  }
}
