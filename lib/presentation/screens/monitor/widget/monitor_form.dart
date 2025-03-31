import 'package:flutter/material.dart';

import '../../../../data/models/monitor_model.dart';
import '../../../../data/models/semester_model.dart';
import '../../../../util/inputs_validator.dart';
import '../../../widgets/custom_button.dart';

class MonitorForm extends StatefulWidget {
  final Function(Monitor monitor) onCreate;
  final List<Semester> semesters;
  final bool showSubmitButton;
  final Monitor? monitor;

  const MonitorForm({
    super.key,
    required this.onCreate,
    required this.semesters,
    this.showSubmitButton = true,
    this.monitor,
  });

  @override
  MonitorFormState createState() => MonitorFormState();
}

class MonitorFormState extends State<MonitorForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nombreController;
  late TextEditingController apellidoController;
  late TextEditingController correoController;
  late TextEditingController totalHorasController;
  late TextEditingController diasAsignadosController;
  String? generoSeleccionado;
  int? semestreSeleccionado;

  final List<String> generos = ['Masculino', 'Femenino'];

  @override
  void initState() {
    super.initState();

    nombreController = TextEditingController(
        text: widget.monitor != null ? widget.monitor!.nombre : '');
    apellidoController = TextEditingController(
        text: widget.monitor != null ? widget.monitor!.apellido : '');
    correoController = TextEditingController(
        text: widget.monitor != null ? widget.monitor!.correo : '');
    totalHorasController = TextEditingController(
        text: widget.monitor != null
            ? widget.monitor!.totalHoras.toString()
            : '');

    diasAsignadosController = TextEditingController(
        text: widget.monitor != null ? widget.monitor!.diasAsignados : '');

    generoSeleccionado = widget.monitor?.genero;
    semestreSeleccionado = widget.monitor?.semestre;

    // Verifica si semestreSeleccionado existe en la lista de semesters
    final isValidSemester =
        widget.semesters.any((s) => s.id == semestreSeleccionado);
    if (!isValidSemester) {
      semestreSeleccionado =
          null;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Monitor monitor = Monitor(
        nombre: nombreController.text,
        apellido: apellidoController.text,
        correo: correoController.text,
        genero: generoSeleccionado ?? '',
        totalHoras: int.tryParse(totalHorasController.text) ?? 0,
      );
      widget.onCreate(monitor);

      if (widget.monitor == null) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputsEnabled = widget.showSubmitButton;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Nombre',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: nombreController,
                        decoration: const InputDecoration(
                          hintText: 'Ejemplo: Juan',
                          border: OutlineInputBorder(),
                        ),
                        enabled: inputsEnabled,
                        validator: (value) {
                          return InputsValidator.validateName(value!);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Apellido',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: apellidoController,
                        decoration: const InputDecoration(
                          hintText: 'Ejemplo: Pérez',
                          border: OutlineInputBorder(),
                        ),
                        enabled: inputsEnabled,
                        validator: (value) {
                          return InputsValidator.validateLastName(value!);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Correo',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextFormField(
              controller: correoController,
              decoration: const InputDecoration(
                hintText: 'Ejemplo: correo@ejemplo.com',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              enabled: inputsEnabled,
              validator: (value) {
                return InputsValidator.validateEmail(value!);
              },
            ),
            const SizedBox(height: 16),
            const Text('Género',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            DropdownButtonFormField<String>(
              value: generoSeleccionado,
              items: generos
                  .map((genero) => DropdownMenuItem(
                value: genero,
                child: Text(genero),
              ))
                  .toList(),
              onChanged: inputsEnabled
                  ? (value) {
                setState(() {
                  generoSeleccionado = value;
                });
              }
                  : null,
              decoration: InputDecoration(
                enabled: inputsEnabled,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: inputsEnabled ? Colors.grey : Colors.grey.shade800,
                  ),
                ),
              ),
              hint: const Text('Selecciona el género'),
              validator: (value) {
                return InputsValidator.validateGender(value);
              },
            ),

            const SizedBox(height: 16),
            Row(
              children: [
                if (widget.monitor != null &&
                    widget.monitor!.semestre != null &&
                    widget.monitor!.semestre! > 0) ...[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Semestre',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        DropdownButtonFormField<int>(
                          value: semestreSeleccionado,
                          items: widget.semesters
                              .map((semester) => DropdownMenuItem(
                                    value: semester.id,
                                    child: Text(semester.nombre),
                                  ))
                              .toList(),
                          onChanged: inputsEnabled
                              ? (value) {
                                  setState(() {
                                    semestreSeleccionado = value;
                                  });
                                }
                              : null,
                          decoration: InputDecoration(
                            enabled: inputsEnabled,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: inputsEnabled ? Colors.grey : Colors.grey.shade800,
                              ),
                            ),
                          ),
                          hint: const Text('Semestre'),
                          validator: (value) {
                            return InputsValidator.validateSemester(value);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                      width:
                          8),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total Horas',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: totalHorasController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Ejemplo: 100',
                          border: OutlineInputBorder(),
                        ),
                        enabled: inputsEnabled,
                        validator: (value) {
                          return InputsValidator.validateTotalHours(value);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            widget.monitor != null &&
                    widget.monitor!.diasAsignados != null &&
                    widget.monitor!.diasAsignados!.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Días Asignados',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        controller: diasAsignadosController,
                        decoration: const InputDecoration(
                          hintText: 'Ejemplo: LunesTarde, MartesMañana',
                          border: OutlineInputBorder(),
                        ),
                        enabled: false,
                        maxLines: null,
                        minLines: 3,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 32),
            if (widget.showSubmitButton)
              CustomButton(
                onPressed: _submitForm,
                isLoading: false,
                text: 'Guardar Monitor',
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nombreController.dispose();
    apellidoController.dispose();
    correoController.dispose();
    totalHorasController.dispose();
    super.dispose();
  }
}
