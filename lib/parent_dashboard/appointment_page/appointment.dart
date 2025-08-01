import 'package:flutter/material.dart';
import 'package:vaccine_scheduler/login_page/login.dart';

class AppointmentScreen extends StatefulWidget {
  final String email;

  const AppointmentScreen({super.key, required this.email});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final TextEditingController vaccineController = TextEditingController();
  String message = '';

  void _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  void _pickTime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
    );
    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  void _submitAppointment() {
    if (selectedDate == null ||
        selectedTime == null ||
        vaccineController.text.isEmpty) {
      setState(() {
        message = "Please fill all fields.";
      });
      return;
    }

    setState(() {
      message =
          "Appointment booked for ${vaccineController.text} on ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} at ${selectedTime!.format(context)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    final role = fakeUserDB[widget.email]?['role'] ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(title: const Text("Appointment")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: role == 'Parent'
            ? Column(
                children: [
                  Text("Logged in as ${widget.email} ($role)",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  TextField(
                    controller: vaccineController,
                    decoration: const InputDecoration(
                      labelText: "Vaccine Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _pickDate,
                          child: Text(selectedDate == null
                              ? "Pick Date"
                              : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _pickTime,
                          child: Text(selectedTime == null
                              ? "Pick Time"
                              : selectedTime!.format(context)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitAppointment,
                    child: const Text("Submit Appointment"),
                  ),
                  const SizedBox(height: 20),
                  Text(message,
                      style:
                          const TextStyle(color: Colors.teal, fontSize: 16)),
                ],
              )
            : Center(
                child: Text(
                  "Appointments are only available for Parents.",
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
      ),
    );
  }
}
