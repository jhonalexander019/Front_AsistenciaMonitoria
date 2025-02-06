class InputsValdiator {
  static String? validateName(String name) {
    if (name.isEmpty) {
      return 'Por favor, ingrese el nombre';
    }

    return null;
  }

  static String? validateLastName(String lastName) {
    if (lastName.isEmpty) {
      return 'Por favor, ingrese el apellido';
    }

    return null;
  }

  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'Por favor, ingrese el correo electrónico';
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return 'Ingrese un correo válido';
    }

    return null;
  }

  static String? validateGender(String gender) {
    if (gender.isEmpty) {
      return 'Seleccione un género';
    }
    return null;
  }

  static String? validateSemester(int semester) {
    if (semester == 0) {
      return 'Seleccione un semestre';
    }
    return null;
  }

  static String? validateTotalHours(String totalHours) {
    if (totalHours.isEmpty) {
      return 'Ingrese el total de horas';
    }

    if (int.parse(totalHours) < 0) {
      return 'El total de horas no puede ser negativo';
    }
    return null;
  }
  
  static String? validateDate(String date) {
    if (date.isEmpty) {
      return 'Seleccione una fecha';
    }
    return null;
  }
}
