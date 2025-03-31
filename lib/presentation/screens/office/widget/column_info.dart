import 'package:flutter/material.dart';

class ColumnInfo extends StatelessWidget {
  final List<String> infoList;

  const ColumnInfo({
    super.key,
    required this.infoList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          infoList.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: infoList
                      .map(
                        (monitor) => Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 4),
                          child: Text(
                            '* $monitor',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      )
                      .toList(),
                )
              : const Text('No hay monitores para esta jornada.'),
        ],
      ),
    );
  }
}
