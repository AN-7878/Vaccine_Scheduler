import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class ChildProfilePage extends StatefulWidget {
  const ChildProfilePage({super.key});

  @override
  State<ChildProfilePage> createState() => _ChildProfilePageState();
}

class _ChildProfilePageState extends State<ChildProfilePage> {
  final nameController = TextEditingController();
  DateTime? selectedDate;
  String? gender;
  File? _image;

  List<Map<String, TextEditingController>> vaccinationControllers = [];

  @override
  void initState() {
    super.initState();
    vaccinationControllers.add({
      'vaccine': TextEditingController(),
      'date': TextEditingController(),
    });
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2020),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _addVaccinationRow() {
    setState(() {
      vaccinationControllers.add({
        'vaccine': TextEditingController(),
        'date': TextEditingController(),
      });
    });
  }

  void _removeVaccinationRow(int index) {
    setState(() {
      vaccinationControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: const Text("Child Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Section (Form)
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Full Name", style: labelStyle),
                  TextField(
                  controller: nameController,
                  ),
                  const SizedBox(height: 10),
                  Text("Date of Birth", style: labelStyle),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _pickDate,
                          child: const Text("Pick Date"),
                        ),
                        const SizedBox(width: 10),
                        if (selectedDate != null)
                          Text("${selectedDate!.toLocal()}".split(' ')[0]),
                      ],
                    ),

                  const SizedBox(height: 20),
                  Text("Gender", style: labelStyle),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Male',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
                      ),
                      const Text('Male'),
                      Radio<String>(
                        value: 'Female',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
                      ),
                      const Text('Female'),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Previous Vaccinations
                 Text("Previous Vaccinations", style: labelStyle),

                  const SizedBox(height: 10),
                  Column(
                    children: List.generate(vaccinationControllers.length, (index) {
                      return Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextField(
                              controller: vaccinationControllers[index]['vaccine'],
                              decoration: InputDecoration(labelText: 'Vaccine Name ${index + 1}'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: TextField(
                              controller: vaccinationControllers[index]['date'],
                              decoration: const InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove_circle, color: Colors.red),
                            onPressed: () => _removeVaccinationRow(index),
                          ),
                        ],
                      );
                    }),
                  ),
                  TextButton.icon(
                    onPressed: _addVaccinationRow,
                    icon: const Icon(Icons.add),
                    label: const Text("Add Vaccination"),
                  ),
                  const SizedBox(height: 20),

                  // Save Button (at the very end)
                  ElevatedButton(
                    onPressed: () {
                      String name = nameController.text;
                      String dob = selectedDate != null
    ? "${selectedDate!.year.toString().padLeft(4, '0')}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}"
    : "Not selected";

                      String selectedGender = gender ?? "Not selected";

                      String vaccinations = vaccinationControllers.asMap().entries.map((entry) {
                        int index = entry.key;
                        var data = entry.value;
                        return "• ${data['vaccine']?.text ?? ''} - ${data['date']?.text ?? ''}";
                      }).join("\n");

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Child Profile Saved"),
                          content: Text("Name: $name\nDOB: $dob\nGender: $selectedGender\n\nVaccinations:\n$vaccinations"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text("Save"),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 20),

            // Right Section (Image Picker)
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? const Icon(Icons.camera_alt, size: 40, color: Colors.grey)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text("Tap to upload photo"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
