import 'base_remote_data_source.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource extends BaseRemoteDataSource {
  Future<User> login(int accessCode) async {
    return postRequest<User>(
      '/sesion/login?codigo=$accessCode',
      {},
          (data) => User.fromJson(data),
    );
  }
}
