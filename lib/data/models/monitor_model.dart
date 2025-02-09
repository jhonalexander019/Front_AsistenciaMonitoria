class Monitor {
  final int? id;
  final String? nombre;
  final String? apellido;
  final String? correo;
  final String? genero;
  final dynamic semestre;
  final int? totalHoras;
  late String? diasAsignados;
  final int? accessCode;

  Monitor({
    this.id,
    this.nombre,
    this.apellido,
    this.correo,
    this.genero,
    this.semestre,
    this.totalHoras,
    this.diasAsignados,
    this.accessCode,
  });

  factory Monitor.fromJson(Map<String, dynamic> json) {
    return Monitor(
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      correo: json['correo'],
      genero: json['genero'],
      semestre: json['semestre'],
      totalHoras: json['totalHoras'],
      diasAsignados: json['diasAsignados'] ?? '',
      accessCode: json['codigo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'apellido': apellido,
      'correo': correo,
      'genero': genero,
      'totalHoras': totalHoras,
      'diasAsignados': diasAsignados ?? '',
    };
  }
}
