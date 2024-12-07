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

  // Método para convertir un JSON a un objeto User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      codigo: json['codigo'],
      genero: json['genero'],
      id: json['id'],
      nombre: json['nombre'],
      rol: json['rol'],
    );
  }

  // Método para convertir un objeto User a JSON
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
