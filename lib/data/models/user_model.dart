class User {
  final int codigo;
  final String genero;
  final int id;
  final String nombre;
  final String apellido;
  final String rol;
  final String? diasAsignados;

  User({
    required this.codigo,
    required this.genero,
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.rol,
    this.diasAsignados,
  });

  Map<String, dynamic> toJson() {
    return {
      'codigo': codigo,
      'genero': genero,
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'rol': rol,
      'diasAsignados': diasAsignados,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      codigo: json['codigo'],
      genero: json['genero'],
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      rol: json['rol'],
      diasAsignados: json['diasAsignados'],
    );
  }
}
