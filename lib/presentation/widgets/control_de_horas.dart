import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ControlDeHorasSection extends StatelessWidget {
  final List<dynamic> horasList;
  final bool isLoading;
  final bool dataIsNull;

  const ControlDeHorasSection(
      {super.key,
      required this.horasList,
      required this.isLoading,
      required this.dataIsNull});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Control de horas',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : dataIsNull
                ? Center(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(123, 36, 46, 73),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'No hay monitores asignados.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : Column(
                    children: horasList.map((monitor) {
                      final horasTrabajadas = monitor['horasCubiertas'] as int;
                      final totalHoras = monitor['totalHoras'] as int;
                      final progreso = horasTrabajadas / totalHoras;
                      final genero = monitor['genero'];
                      final svgImagePath = genero == "Masculino"
                          ? 'assets/images/male.svg'
                          : 'assets/images/female.svg';

                      return Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 12.0),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(29, 43, 73, 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              svgImagePath,
                              width: 50,
                              height: 50,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        monitor['nombre'],
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        '${horasTrabajadas.toString()}/$totalHoras',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  LinearProgressIndicator(
                                    borderRadius: BorderRadius.circular(6),
                                    value: progreso,
                                    backgroundColor: Colors.grey[300],
                                    color: Colors.red,
                                    minHeight: 16,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
      ],
    );
  }
}
