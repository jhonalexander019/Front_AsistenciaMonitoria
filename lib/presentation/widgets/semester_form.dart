import 'package:flutter/material.dart';
import 'package:front_asistencia_monitoria/util/inputs_validator.dart';

import '../../data/models/semester_model.dart';

class SemesterForm extends StatefulWidget {
  final Function(Semester semester) onCreate;
  final Semester? semestre;

  const SemesterForm({super.key, required this.onCreate, this.semestre});

  @override
  _SemesterFormState createState() => _SemesterFormState();
}

class _SemesterFormState extends State<SemesterForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nombreController;
  late TextEditingController fechaInicioController;
  late TextEditingController fechaFinController;

  @override
  void initState() {
    super.initState();
      nombreController = TextEditingController(text: widget.semestre != null ? widget.semestre!.nombre : '');
      fechaInicioController =
          TextEditingController(text: widget.semestre != null ? widget.semestre!.fechaInicio : '');
      fechaFinController = TextEditingController(text: widget.semestre != null ? widget.semestre!.fechaFin : '');
  
  }

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

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Nombre',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextFormField(
              controller: nombreController,
              decoration: const InputDecoration(
                hintText: 'Ejemplo: 2024-2',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                return InputsValdiator.validateName(value!);
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
                          return InputsValdiator.validateDate(value!);
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
                          return InputsValdiator.validateDate(value!);
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
              child: const Text('Guardar Semestre'),
            ),
          ],
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
