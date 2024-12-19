class User {
  final int codigo;
  final String genero;
  final int id;
  final String nombre;
  final String rol;

  User({
    required this.codigo,
    required this.genero,
    required this.id,
    required this.nombre,
    required this.rol,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      codigo: json['codigo'],
      genero: json['genero'],
      id: json['id'],
      nombre: json['nombre'],
      rol: json['rol'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codigo': codigo,
      'genero': genero,
      'id': id,
      'nombre': nombre,
      'rol': rol,
    };
  }
}
