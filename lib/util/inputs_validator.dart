class InputsValidator {
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

  static String? validateGender(String? gender) {
    if (gender == null) {
      return 'Seleccione un género';
    }
    return null;
  }

  static String? validateSemester(int? semester) {
    if (semester == 0 || semester == null) {
      return 'Seleccione un semestre';
    }
    return null;
  }

  static String? validateTotalHours(String? totalHours) {
    if (totalHours!.isEmpty) {
      return 'Ingrese el total de horas';
    }

    if (double.parse(totalHours) <= 0.0) {
      return 'Ingrese una cantidad de horas razonable';
    }
    return null;
  }
  
  static String? validateDate(String date) {
    if (date.isEmpty) {
      return 'Seleccione una fecha';
    }
    return null;
  }

  static String? validateMonitor(int? monitor) {
    if (monitor == 0 || monitor == null) {
      return 'Seleccione un monitor';
    }
    return null;
  }

  static String? validateDay(String? day) {
    if (day == null) {
      return 'Seleccione una jornada';
    }
    return null;
  }

  static String? validateState(String? state) {
    if (state == null) {
      return 'Seleccione un estado';
    }
    return null;
  }
}
