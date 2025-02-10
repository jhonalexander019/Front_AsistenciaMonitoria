import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/user_model.dart';
import '../../domain/usecases/login_usecase.dart';
import '../screens/admin_screen.dart';
import '../screens/monitor_screen.dart';
import 'storage_bloc.dart';

class LoginBloc with ChangeNotifier {
  final LoginUseCase loginUsecase;
  String? message;
  bool? successMessage;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  LoginBloc(this.loginUsecase);

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> login(BuildContext context, String accessCode) async {
    if (accessCode.length != 4 || int.tryParse(accessCode) == null) {
      message = "El código de acceso debe contener exactamente 4 números.";
      successMessage = false;
      notifyListeners();
      return;
    }

    try {
      isLoading = true;

      User user = await loginUsecase(int.parse(accessCode));

      Provider.of<StorageBloc>(context, listen: false).saveUser(user.toJson());

      Widget nextScreen =
          user.rol == 'Monitor' ? const MonitorScreen() : const AdminScreen();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => nextScreen),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      message = e.toString().replaceAll('Exception: ', '');
      successMessage = false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
