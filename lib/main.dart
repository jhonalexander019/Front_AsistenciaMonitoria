import 'package:flutter/material.dart';
import 'data/datasources/admin_remote_data_source.dart';
import 'data/repositories/admin_repository_impl.dart';
import 'domain/usecases/admin_usecase.dart';
import 'presentation/viewmodels/admin_bloc.dart';
import 'util/session_validator.dart';
import 'package:provider/provider.dart';

import 'data/datasources/auth_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/usecases/login_usecase.dart';
import 'presentation/viewmodels/login_bloc.dart';
import 'presentation/viewmodels/storage_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final authRemoteDataSource = AuthRemoteDataSource();
    final adminRemoteDataSource = AdminRemoteDataSource();
    final authRepository = AuthRepositoryImpl(authRemoteDataSource);
    final adminRepository = AdminRepositoryImpl(adminRemoteDataSource);
    final loginUserUseCase = LoginUseCase(authRepository);
    final adminUserUseCase = AdminUseCase(adminRepository);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginBloc(loginUserUseCase),
        ),
        ChangeNotifierProvider(
          create: (_) => AdminBloc(adminUserUseCase),
        ),
        ChangeNotifierProvider(
          create: (_) => StorageBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Unillanos',
        theme: ThemeData(
          fontFamily: 'Poppins',
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          fontFamily: 'Poppins',
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.system,
        home:  const SessionValidator(),
      ),
    );
  }
}