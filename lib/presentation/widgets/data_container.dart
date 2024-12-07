import 'package:flutter/material.dart';

import 'column_info.dart';

class DataContainer extends StatelessWidget {
  final bool isLoading;
  final bool dataIsNull;
  final List<dynamic> mananaList;
  final List<dynamic> tardeList;

  const DataContainer({
    super.key,
    required this.isLoading,
    required this.dataIsNull,
    required this.mananaList,
    required this.tardeList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(29, 43, 73, 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : dataIsNull
              ? const Center(
                  child: Text(
                    'No hay monitores para este día.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Columna para Mañana
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.wb_sunny,
                                  color: Colors.yellowAccent),
                              const SizedBox(width: 8),
                              const Text(
                                'Mañana',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ColumnInfo(
                            infoList: mananaList
                                .map((e) => e['nombre'].toString())
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Columna para Tarde
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.nightlight_round,
                                  color: Colors.yellowAccent),
                              const SizedBox(height: 8),
                              const Text(
                                'Tarde',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ColumnInfo(
                            infoList: tardeList
                                .map((e) => e['nombre'].toString())
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
