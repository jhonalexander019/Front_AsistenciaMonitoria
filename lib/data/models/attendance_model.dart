class Attendance{
  final String fecha;
  final String nombre;
  final String apellido;
  final String jornada;
  final String estado;

  Attendance({
    required this.fecha,
    required this.nombre,
    required this.apellido,
    required this.jornada,
    required this.estado,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      fecha: json['fecha'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      jornada: json['jornada'],
      estado: json['estado'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fecha': fecha,
      'nombre': nombre,
      'apellido': apellido,
      'jornada': jornada,
      'estado': estado,
    };
  }

}