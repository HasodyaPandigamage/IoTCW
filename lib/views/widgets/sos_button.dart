import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/alert_controller.dart';

class SosButton extends StatelessWidget {
  const SosButton({super.key});

  @override
  Widget build(BuildContext context) {
    final alertController = Provider.of<AlertController>(context, listen: false);

    return ElevatedButton(
      onPressed: () {
        alertController.sendSosAlert();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('SOS Alert Sent!')),
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 60),
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 8,
      ),
      child: const Text(
        "SOS",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}