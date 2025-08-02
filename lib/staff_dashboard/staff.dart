import 'package:flutter/material.dart';
import 'package:vaccine_scheduler/login_page/login.dart';

void main() {
  runApp(const StaffDashboard());
}

class StaffDashboard extends StatelessWidget {
  const StaffDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Staff Dashboard',
      theme: ThemeData(primarySwatch: Colors.yellow),
      debugShowCheckedModeBanner: false,
      home: StaffDashboard(),
    );
  }
}

class Vaccine {
  String name;
  String dose;
  bool available;

  Vaccine({required this.name, required this.dose, this.available = true});
}

class SdPage extends StatefulWidget {
  const SdPage({super.key});
  @override
  State<SdPage> createState() => _SdPageState();
}

class _SdPageState extends State<SdPage> {
  List<Vaccine> vaccines = [
    Vaccine(name: "BCG", dose: "Single Dose"),
    Vaccine(name: "Polio", dose: "3 Doses"),
    Vaccine(name: "Hepatitis B", dose: "3 Doses"),
  ];

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _doseController = TextEditingController();

  void _addVaccine() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        vaccines.add(
          Vaccine(name: _nameController.text, dose: _doseController.text),
        );
      });
      _nameController.clear();
      _doseController.clear();
      Navigator.pop(context);
    }
  }

  void _editVaccine(int index) {
    _nameController.text = vaccines[index].name;
    _doseController.text = vaccines[index].dose;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Edit Vaccine", style: TextStyle(fontSize: 18)),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Vaccine Name"),
                validator: (value) =>
                    value!.isEmpty ? "Enter vaccine name" : null,
              ),
              TextFormField(
                controller: _doseController,
                decoration: InputDecoration(labelText: "Dose Info"),
                validator: (value) => value!.isEmpty ? "Enter dose info" : null,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      vaccines[index].name = _nameController.text;
                      vaccines[index].dose = _doseController.text;
                    });
                    _nameController.clear();
                    _doseController.clear();
                    Navigator.pop(context);
                  }
                },
                child: Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddVaccineForm() {
    _nameController.clear();
    _doseController.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Add Vaccine", style: TextStyle(fontSize: 18)),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Vaccine Name"),
                validator: (value) =>
                    value!.isEmpty ? "Enter vaccine name" : null,
              ),
              TextFormField(
                controller: _doseController,
                decoration: InputDecoration(labelText: "Dose Info"),
                validator: (value) => value!.isEmpty ? "Enter dose info" : null,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addVaccine,
                child: Text("Add Vaccine"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Staff Dashboard"), centerTitle: true),
      body: ListView.builder(
        itemCount: vaccines.length,
        itemBuilder: (context, index) {
          final vaccine = vaccines[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: ListTile(
              title: Text(vaccine.name),
              subtitle: Text(vaccine.dose),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Switch(
                    value: vaccine.available,
                    onChanged: (val) {
                      setState(() {
                        vaccine.available = val;
                      });
                    },
                    activeColor: Colors.green,
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _editVaccine(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        vaccines.removeAt(index);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddVaccineForm,
        child: Icon(Icons.add),
      ),
    );
  }
}
