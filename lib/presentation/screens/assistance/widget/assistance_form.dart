import 'package:flutter/material.dart';

import '../../../../data/models/assistance_model.dart';
import '../../../../data/models/monitor_model.dart';
import '../../../../util/inputs_validator.dart';
import '../../../widgets/custom_button.dart';

class AssistanceForm extends StatefulWidget {
  final Function(Assistance assistance) onCreate;
  final List<Monitor> monitors;
  final bool showSubmitButton;
  final Assistance? assistance;

  const AssistanceForm({
    super.key,
    required this.onCreate,
    required this.monitors,
    this.showSubmitButton = true,
    this.assistance,
  });

  @override
  AssistanceFormState createState() => AssistanceFormState();
}

class AssistanceFormState extends State<AssistanceForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController totalHorasController;
  late TextEditingController fechaController;
  String? jornadaSeleccionada;
  String? estadoSeleccionado;
  int? monitorSeleccionado;

  final List<String> estados = ['Presente', 'Ausente', 'Recuperado'];
  final List<String> jornadas = ['Mañana', 'Tarde'];

  late bool initialShowSubmitButton = false;

  @override
  void initState() {
    super.initState();

    initialShowSubmitButton = widget.showSubmitButton;

    if (widget.assistance != null) {
      final monitor = widget.monitors.firstWhere(
        (m) =>
            m.nombre == widget.assistance!.nombre &&
            m.apellido == widget.assistance!.apellido,
        orElse: () => Monitor(id: -1, nombre: "", apellido: ""),
      );
      monitorSeleccionado = monitor.id != -1 ? monitor.id : null;
    }

    totalHorasController =
        TextEditingController(text: widget.assistance?.totalHoras.toString() ?? '');
    fechaController = TextEditingController(text: widget.assistance?.fecha);
    jornadaSeleccionada = widget.assistance?.jornada;
    estadoSeleccionado = widget.assistance?.estado;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Assistance assistance;

      if (widget.assistance == null) {
        // Creación de una nueva asistencia (se envía monitorId, jornada, horas y estado)
        assistance = Assistance(
          monitorId: monitorSeleccionado,
          jornada: jornadaSeleccionada!,
          estado: estadoSeleccionado!,
          totalHoras: double.tryParse(totalHorasController.text) ?? 0.0,
          nombre: "",
          apellido: "",
        );
      } else {
        // Actualización de una asistencia existente (se envía id, horas y estado)
        assistance = Assistance(
          id: widget.assistance!.id,
          estado: estadoSeleccionado!,
          totalHoras: double.tryParse(totalHorasController.text) ?? 0.0,
          nombre: widget.assistance!.nombre,
          apellido: widget.assistance!.apellido,
          jornada: widget.assistance!.jornada,
        );
      }

      widget.onCreate(assistance);

      if (widget.assistance == null) {
        Navigator.pop(context);
      }
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
            widget.assistance != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        const Text('Fecha',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        TextFormField(
                          controller: fechaController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          enabled: false,
                        ),
                        const SizedBox(height: 16),
                      ])
                : const SizedBox.shrink(),
            const Text('Monitor',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            DropdownButtonFormField<int>(
              value: monitorSeleccionado,
              items: widget.monitors
                  .map((monitor) => DropdownMenuItem(
                        value: monitor.id,
                        child: Text('${monitor.nombre} ${monitor.apellido}'),
                      ))
                  .toList(),
              onChanged: initialShowSubmitButton
                  ? (value) {
                      setState(() {
                        monitorSeleccionado = value;
                      });
                    }
                  : null,
              decoration: InputDecoration(
                enabled: initialShowSubmitButton,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: initialShowSubmitButton
                        ? Colors.grey
                        : Colors.grey.shade800,
                  ),
                ),
              ),
              hint: const Text('Selecciona un monitor'),
              validator: (value) {
                return InputsValidator.validateMonitor(value);
              },
            ),
            const SizedBox(height: 16),
            const Text('Jornada',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            DropdownButtonFormField<String>(
              value: jornadaSeleccionada,
              items: jornadas
                  .map((jornada) => DropdownMenuItem(
                        value: jornada,
                        child: Text(jornada),
                      ))
                  .toList(),
              onChanged: initialShowSubmitButton
                  ? (value) {
                      setState(() {
                        jornadaSeleccionada = value;
                      });
                    }
                  : null,
              decoration: InputDecoration(
                enabled: initialShowSubmitButton,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: initialShowSubmitButton
                        ? Colors.grey
                        : Colors.grey.shade800,
                  ),
                ),
              ),
              hint: const Text('Selecciona la jornada'),
              validator: (value) {
                return InputsValidator.validateDay(value);
              },
            ),
            const SizedBox(height: 16),
            const Text('Estado',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            DropdownButtonFormField<String>(
              value: estadoSeleccionado,
              items: estados
                  .map((estado) => DropdownMenuItem(
                        value: estado,
                        child: Text(estado),
                      ))
                  .toList(),
              onChanged: inputsEnabled
                  ? (value) {
                      setState(() {
                        estadoSeleccionado = value;
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
              hint: const Text('Selecciona el estado'),
              validator: (value) {
                return InputsValidator.validateState(value);
              },
            ),
            const SizedBox(height: 16),
            const Text('Total Horas',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextFormField(
              controller: totalHorasController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Ejemplo: 4',
                border: OutlineInputBorder(),
              ),
              enabled: inputsEnabled,
              validator: (value) {
                return InputsValidator.validateTotalHours(value);
              },
            ),
            const SizedBox(height: 32),
            if (widget.showSubmitButton)
              CustomButton(
                onPressed: _submitForm,
                isLoading: false,
                text: 'Guardar Asistencia',
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    totalHorasController.dispose();
    super.dispose();
  }
}
