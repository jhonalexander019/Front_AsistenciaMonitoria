import 'package:intl/intl.dart';

class Assistance {
  final int? id;
  final String? fecha;
  final String nombre;
  final String apellido;
  final String jornada;
  final String estado;
  final double? totalHoras;
  final int? monitorId;

  Assistance({
    this.id,
    this.fecha,
    required this.nombre,
    required this.apellido,
    required this.jornada,
    required this.estado,
    this.totalHoras,
    this.monitorId,
  });

  factory Assistance.fromJson(Map<String, dynamic> json) {
    // Parse the date string to DateTime
    DateTime? dateTime;
    if (json['fecha'] != null) {
      dateTime = DateTime.tryParse(json['fecha']);
    }

    // Format the DateTime to dd-MM-yyyy
    String? formattedDate;
    if (dateTime != null) {
      final formatter = DateFormat('dd-MM-yyyy');
      formattedDate = formatter.format(dateTime);
    }

    return Assistance(
      id: json['id'],
      fecha: formattedDate,
      nombre: json['monitor']['nombre'],
      apellido: json['monitor']['apellido'],
      jornada: json['jornada'],
      estado: json['estado'],
      totalHoras: json['horasCubiertas'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return id != null
        ? {
      'id': id,
      'estado': estado,
      'horas': totalHoras,
    }
        : {
      'monitorId': monitorId,
      'jornada': jornada,
      'estado': estado,
      'horas': totalHoras,
    };
  }
}
