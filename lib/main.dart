import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'util/session_validator.dart';

import 'data/datasources/auth_remote_data_source.dart';
import 'data/datasources/admin_remote_data_source.dart';
import 'data/datasources/semester_remote_data_source.dart';
import 'data/datasources/monitor_remote_data_source.dart';

import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/admin_repository_impl.dart';
import 'data/repositories/semester_repository_impl.dart';
import 'data/repositories/monitor_repository_impl.dart';

import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/admin_usecase.dart';
import 'domain/usecases/semester_usecase.dart';
import 'domain/usecases/monitor_usecase.dart';

import 'presentation/viewmodels/login_bloc.dart';
import 'presentation/viewmodels/admin_bloc.dart';
import 'presentation/viewmodels/semester_bloc.dart';
import 'presentation/viewmodels/monitor_bloc.dart';
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
    final semesterRemoteDataSource = SemesterRemoteDataSource();
    final monitorRemoteDataSource = MonitorRemoteDataSource();

    final authRepository = AuthRepositoryImpl(authRemoteDataSource);
    final adminRepository = AdminRepositoryImpl(adminRemoteDataSource);
    final semesterRepository = SemesterRepositoryImpl(semesterRemoteDataSource);
    final monitorRepository = MonitorRepositoryImpl(monitorRemoteDataSource);

    final loginUserUseCase = LoginUseCase(authRepository);
    final adminUserUseCase = AdminUseCase(adminRepository);
    final semesterUserUseCase = SemesterUsecase(semesterRepository);
    final monitorUserUseCase = MonitorUsecase(monitorRepository);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginBloc(loginUserUseCase),
        ),
        ChangeNotifierProvider(
          create: (_) => AdminBloc(adminUserUseCase),
        ),
        ChangeNotifierProvider(
          create: (_) => SemesterBloc(semesterUserUseCase),
        ),
        ChangeNotifierProvider(
          create: (_) => MonitorBloc(monitorUserUseCase),
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

        home: const SessionValidator(),
      ),
    );
  }
}
