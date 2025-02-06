class Semester {
  final int? id;
  final String nombre;
  final String fechaInicio;
  final String fechaFin;

  Semester({
    this.id,
    required this.nombre,
    required this.fechaInicio,
    required this.fechaFin,
  });

  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
      id: json['id'],
      nombre: json['nombre'],
      fechaInicio: json['fechaInicio'],
      fechaFin: json['fechaFin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'fechaInicio': fechaInicio,
      'fechaFin': fechaFin,
    };
  }
}
