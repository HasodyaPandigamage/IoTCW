import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/medicine_controller.dart';
import '../../models/medicine_model.dart';
import 'add_medicine_dialog.dart';

class MedicineStatusCard extends StatelessWidget {
  const MedicineStatusCard({super.key});

  void _showAddMedicineDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const AddMedicineDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final medicineController = Provider.of<MedicineController>(context);
    final medicines = medicineController.medicines;
    final bool canAddMore = medicines.length < 3;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Medicine Box Status",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    color: canAddMore ? Colors.blue : Colors.grey,
                    size: 30,
                  ),
                  onPressed: canAddMore ? () => _showAddMedicineDialog(context) : null,
                  tooltip: canAddMore ? 'Add Medicine' : 'Medicine box is full',
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (medicines.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("No medicine schedule found. Tap '+' to add."),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: medicines.length,
                itemBuilder: (ctx, index) => MedicineRow(medicine: medicines[index]),
              ),
          ],
        ),
      ),
    );
  }
}

class MedicineRow extends StatelessWidget {
  final Medicine medicine;
  const MedicineRow({super.key, required this.medicine});

  void _showDeleteConfirmation(BuildContext context, MedicineController controller) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Are you sure?'),
        content: Text('Do you want to remove "${medicine.name}"?'),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              controller.deleteMedicine(medicine.id);
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final medicineController = Provider.of<MedicineController>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent),
            onPressed: () => _showDeleteConfirmation(context, medicineController),
            tooltip: 'Delete Medicine',
          ),
          Expanded(
            child: Text(
              "${medicine.name} (${medicine.dosageTime})",
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // This Column holds the switch and the "Taken" text
          Column(
            children: [
              Switch(
                // The switch is ON when taken is false (medicine is ready)
                value: !medicine.taken,
                // The user cannot change the switch from the app
                onChanged: null,
              ),
              // This part shows the "Taken" text only if medicine.taken is true
              if (medicine.taken)
                const Text(
                  "Taken",
                  style: TextStyle(fontSize: 12, color: Colors.green),
                ),
            ],
          ),
        ],
      ),
    );
  }
}