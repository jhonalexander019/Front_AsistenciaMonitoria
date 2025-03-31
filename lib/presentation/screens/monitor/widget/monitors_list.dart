import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../data/models/monitor_model.dart';
import '../../../widgets/custom_list_widget_.dart';
import '../profile_monitor_screen.dart';

class MonitorsList extends StatelessWidget {
  final List<Monitor>? monitors;
  final bool isLoading;

  const MonitorsList({
    super.key,
    required this.monitors,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListWidget<Monitor>(
      items: monitors ?? [],
      isLoading: isLoading,
      dataIsNull: monitors?.isEmpty ?? true,
      onItemTap: (context, monitor) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileMonitorScreen(monitor: monitor),
          ),
        );
      },
      title: "Monitores",
      noDataMessage: "No hay monitores creados.",
      itemBuilder: (monitor) {
        final svgImagePath = monitor.genero == "Masculino"
            ? 'assets/images/male.svg'
            : 'assets/images/female.svg';
        return ListTile(
          leading: SvgPicture.asset(svgImagePath, width: 60, height: 60),
          title: Text(
            "${monitor.nombre} ${monitor.apellido}",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Row(
            children: [
              Text('Acceso: ${monitor.accessCode}'),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(
                    ClipboardData(
                      text: monitor.accessCode.toString(),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '¡Código de acceso copiado al portapapeles!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: Colors.blue,
                      duration: const Duration(seconds: 3),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  );
                },
                child: const Icon(
                  Icons.copy,
                  size: 16,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
