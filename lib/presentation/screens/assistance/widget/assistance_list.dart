import 'package:flutter/material.dart';

import '../../../../data/models/assistance_model.dart';
import '../../../widgets/custom_list_widget_.dart';
import '../profile_assistance_screen.dart';

class AssistanceList extends StatelessWidget {
  final List<Assistance>? assistances;
  final bool isLoading;

  const AssistanceList({
    super.key,
    required this.assistances,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListWidget<Assistance>(
      items: assistances ?? [],
      isLoading: isLoading,
      dataIsNull: assistances == null || assistances!.isEmpty,
      ownStyle: true,
      onItemTap: (context, assistance) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileAssistanceScreen(assistance: assistance),
          ),
        );
      },
      title: "Asistencias",
      noDataMessage: "Aún no hay asistencias registradas por parte de los monitores.",
      itemBuilder: (assistance) {
        final colorScheme = _getRowColors(assistance.estado);

        return Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 12.0),
          decoration: BoxDecoration(
            color: colorScheme['background'],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 90,
                child: Text(assistance.fecha!,
                    style: TextStyle(color: colorScheme['text'])),
              ),
              const SizedBox(width: 24),
              SizedBox(
                width: 120,
                child: Text(
                    '${assistance.nombre} ${assistance.apellido}',
                    style: TextStyle(color: colorScheme['text'])),
              ),
              const SizedBox(width: 24),
              SizedBox(
                width: 70,
                child: Text(assistance.jornada,
                    style: TextStyle(color: colorScheme['text'])),
              ),
            ],
          ),
        );
      },
    );
  }

  Map<String, Color> _getRowColors(String estado) {
    switch (estado) {
      case 'Presente':
        return {
          'background': const Color(0xFFE8F5E9),
          'text': Colors.green.shade800
        };
      case 'Ausente':
        return {
          'background': const Color(0xFFFFEBEE),
          'text': Colors.red.shade800
        };
      case 'Recuperado':
        return {
          'background': const Color(0xFFFFF3E0),
          'text': Colors.orange.shade800
        };
      default:
        return {'background': Colors.white, 'text': Colors.black};
    }
  }
}
