import 'package:flutter/material.dart';

import '../../data/models/semester_model.dart';

class SemesterForm extends StatefulWidget {
  final Function(Semester semester) onCreate;

  const SemesterForm({super.key, required this.onCreate});

  @override
  _SemesterFormState createState() => _SemesterFormState();
}

class _SemesterFormState extends State<SemesterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController fechaInicioController = TextEditingController();
  final TextEditingController fechaFinController = TextEditingController();

  void _selectDateRange(BuildContext context) async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 30)),
      ),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        fechaInicioController.text =
            picked.start.toIso8601String().split('T').first;
        fechaFinController.text = picked.end.toIso8601String().split('T').first;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Semester semester = Semester(
        nombre: nombreController.text,
        fechaInicio: fechaInicioController.text,
        fechaFin: fechaFinController.text,
      );
      widget.onCreate(semester);

      // Cerramos el formulario
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Crear Semestre',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const Text('Nombre',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(
                  hintText: 'Ejemplo: 2024-2',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese un nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text('Rango de fecha',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDateRange(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: fechaInicioController,
                          decoration: const InputDecoration(
                            hintText: 'Fecha inicio',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Seleccione fecha inicio';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text("-"),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDateRange(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: fechaFinController,
                          decoration: const InputDecoration(
                            hintText: 'Fecha fin',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Seleccione fecha fin';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(84, 22, 43, 1.000),
                  minimumSize: const Size(double.infinity, 40),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: const Text('Crear Semestre'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nombreController.dispose();
    fechaInicioController.dispose();
    fechaFinController.dispose();
    super.dispose();
  }
}
