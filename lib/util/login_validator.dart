class LoginValidator {
  static String? validateAccessCode(int accessCode) {
  if (accessCode < 0) {
    return 'Código inválido';
  }

  if (accessCode.toString().length != 4) {
    return 'El código debe tener 4 dígitos';
  }

  return null;
}

}
