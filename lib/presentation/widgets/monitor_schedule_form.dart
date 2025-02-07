import 'package:flutter/material.dart';

import '../../data/models/monitor_model.dart';

class MonitorScheduleForm extends StatefulWidget {
  final Function(Monitor monitor) onUpdate;
  final String? schedule;

  const MonitorScheduleForm({
    super.key,
    required this.onUpdate,
    this.schedule,
  });

  @override
  _MonitorScheduleFormState createState() => _MonitorScheduleFormState();
}

class _MonitorScheduleFormState extends State<MonitorScheduleForm> {
  late Map<String, Map<String, bool>> schedule;

  @override
  void initState() {
    super.initState();

    schedule = {
      "Lunes": {"No Asignado": true, "Mañana": false, "Tarde": false},
      "Martes": {"No Asignado": true, "Mañana": false, "Tarde": false},
      "Miércoles": {"No Asignado": true, "Mañana": false, "Tarde": false},
      "Jueves": {"No Asignado": true, "Mañana": false, "Tarde": false},
      "Viernes": {"No Asignado": true, "Mañana": false, "Tarde": false},
    };

    if (widget.schedule != null && widget.schedule!.isNotEmpty) {
      _parseSchedule(widget.schedule!);
    }
  }

  void _parseSchedule(String scheduleString) {
    List<String> assignments = scheduleString.split(", ");

    for (String assignment in assignments) {
      String shift = '';
      String day = assignment;

      if (assignment.contains("Mañana")) {
        shift = "Mañana";
        day = assignment.replaceAll("Mañana", "").trim();
      } else if (assignment.contains("Tarde")) {
        shift = "Tarde";
        day = assignment.replaceAll("Tarde", "").trim();
      }

      if (schedule.containsKey(day)) {
        setState(() {
          schedule[day]!["No Asignado"] = false;
          schedule[day]![shift] = true;
        });
      }
    }
  }

  String get diasAsignados {
    StringBuffer result = StringBuffer();
    schedule.forEach((day, options) {
      if (!options['No Asignado']!) {
        if (options['Mañana']!) result.write("${day}Mañana, ");
        if (options['Tarde']!) result.write("${day}Tarde, ");
      }
    });
    return result.isNotEmpty
        ? result.toString().substring(0, result.length - 2)
        : "";
  }

  void _toggleOption(String day, String option) {
    setState(() {
      if (option == 'No Asignado') {
        schedule[day]?.updateAll((key, value) => key == 'No Asignado');
      } else {
        schedule[day]?['No Asignado'] = false;
        schedule[day]?[option] = !(schedule[day]?[option] ?? false);
        if (!schedule[day]!['Mañana']! && !schedule[day]!['Tarde']!) {
          schedule[day]?['No Asignado'] = true;
        }
      }
    });
  }

  void _submitForm() {
    Monitor monitor = Monitor(
      diasAsignados: diasAsignados,
    );

    widget.onUpdate(monitor);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...schedule.keys.map((day) => _buildDayRow(day)).toList(),
          const SizedBox(height: 20),
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
            child: const Text('Guardar Horario'),
          ),
        ],
      ),
    );
  }

  Widget _buildDayRow(String day) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            day,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Row(
            children: [
              _buildRadioOption(day, 'No Asignado'),
              _buildCheckboxOption(day, 'Mañana'),
              _buildCheckboxOption(day, 'Tarde'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(String day, String option) {
    return Flexible(
      child: GestureDetector(
        onTap: () => _toggleOption(day, option),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<bool>(
              value: true,
              groupValue: schedule[day]?[option],
              onChanged: (_) => _toggleOption(day, option),
            ),
            Flexible(
              child: Text(
                option,
                style: const TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxOption(String day, String option) {
    return Flexible(
      child: GestureDetector(
        onTap: () => _toggleOption(day, option),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: schedule[day]?[option],
              onChanged: (_) => _toggleOption(day, option),
            ),
            Flexible(
              child: Text(
                option,
                style: const TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
