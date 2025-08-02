import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const VaccineTimeline());
}

class VaccineTimeline extends StatelessWidget {
  const VaccineTimeline({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vaccine Timeline',
      debugShowCheckedModeBanner: false,
      home: VaccineTimelinePage(),
    );
  }
}
class Vaccine {
  final String name;
  final DateTime date;
  bool completed;

  Vaccine({
    required this.name,
    required this.date,
    this.completed = false,
  });
}
class VaccineTimelinePage extends StatefulWidget {
  const VaccineTimelinePage({super.key});

  @override
  State<VaccineTimelinePage> createState() => _VaccineTimelinePageState();
}

class _VaccineTimelinePageState extends State<VaccineTimelinePage> {
  List<Vaccine> vaccineList = [
    Vaccine(name: "BCG", date: DateTime(2025, 9, 1)),
    Vaccine(name: "Hepatitis B", date: DateTime(2025, 9, 15)),
    Vaccine(name: "Polio", date: DateTime(2025, 10, 1)),
    Vaccine(name: "DTP", date: DateTime(2025, 11, 15)),
    Vaccine(name: "MMR", date: DateTime(2026, 1, 5)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vaccine Timeline")),
      body: ListView.builder(
        itemCount: vaccineList.length,
        itemBuilder: (context, index) {
          final vaccine = vaccineList[index];
          final isUpcoming = DateTime.now().isBefore(vaccine.date);

          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 3,
            child: ListTile(
              leading: Icon(
                vaccine.completed
                    ? Icons.check_circle
                    : Icons.circle_outlined,
                color: vaccine.completed
                    ? Colors.green
                    : (isUpcoming ? Colors.orange : Colors.grey),
              ),
              title: Text(vaccine.name),
              subtitle: Text(
                "Scheduled: ${DateFormat('yyyy-MM-dd').format(vaccine.date)}",
              ),
              trailing: !vaccine.completed
                  ? ElevatedButton(
                      child: const Text("Mark Done"),
                      onPressed: () {
                        setState(() {
                          vaccine.completed = true;
                        });
                      },
                    )
                  : const Icon(Icons.check, color: Colors.green),
            ),
          );
        },
      ),
    );
  }
}
