import '../../data/models/user_model.dart';

abstract class AuthRepository {
  Future<User> login(int accessCode);
}
