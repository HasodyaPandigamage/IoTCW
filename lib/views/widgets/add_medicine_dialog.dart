import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/medicine_controller.dart';
import '../../models/medicine_model.dart';

class AddMedicineDialog extends StatefulWidget {
  const AddMedicineDialog({super.key});

  @override
  State<AddMedicineDialog> createState() => _AddMedicineDialogState();
}

class _AddMedicineDialogState extends State<AddMedicineDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _timeController = TextEditingController();
  // This new variable will hold the state of the switch in the dialog
  bool _isMedicineReady = false;

  @override
  void dispose() {
    _nameController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final medicineName = _nameController.text;
      final dosageTime = _timeController.text;

      // Create the medicine object. 'taken' is always false to start,
      // because the switch in the dialog confirms it's ready.
      final newMedicine = Medicine(
        id: '', // The controller will figure out which slot to use
        name: medicineName,
        dosageTime: dosageTime,
        taken: false,
      );

      Provider.of<MedicineController>(context, listen: false).addMedicine(newMedicine);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Medicine'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Medicine Name',
                hintText: 'e.g., Aspirin',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a medicine name.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _timeController,
              decoration: const InputDecoration(
                labelText: 'Dosage Time',
                hintText: 'e.g., 8:00 AM',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a dosage time.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // This is the new switch inside the dialog
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Medicine is in the box?'),
                Switch(
                  value: _isMedicineReady,
                  onChanged: (value) {
                    setState(() {
                      _isMedicineReady = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        // The "Add" button is only enabled if the switch is ON
        ElevatedButton(
          onPressed: _isMedicineReady ? _submitForm : null,
          child: const Text('Add'),
        ),
      ],
    );
  }
}