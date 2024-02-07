import 'data/datasource/test.dart';

import 'data/datasource/patient_datasource.dart';
import 'data/repository/patient_repository.dart';
import 'presentation/cubits/patient_cubit/patient_cubit.dart';
import 'presentation/screens/main_home.dart';
import 'presentation/screens/splash_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'presentation/screens/welcome/welcome_screen.dart';
import 'services/local_notifications.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/constants.dart';
import 'data/datasource/auth_datasource.dart';
import 'data/datasource/staff_datasource.dart';
import 'data/repository/auth_repository.dart';
import 'data/repository/staff_repository.dart';
import 'firebase_options.dart';
import 'presentation/cubits/auth_cubit/auth_cubit.dart';
import 'presentation/cubits/staff_cubit/staff_cubit.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }

  await LocalNotification.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  TestFire.getChildrenBusses();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(
            authRepository: AuthRepository(
              dataSource: AuthDataSource(),
            ),
          ),
        ),
        BlocProvider<StaffCubit>(
          create: (context) => StaffCubit(
            staffRepository: StaffRepository(
              dataSource: StaffDataSource(),
            ),
          ),
        ),
        BlocProvider<PatientCubit>(
          create: (context) => PatientCubit(
            patientRepository: PatientRepository(
              dataSource: PatientDataSource(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Cura Tech',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: AnimatedSplashScreen(
          centered: true,
          splash: const SplashScreen(),
          splashIconSize: 500,
          nextScreen: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, streamSnapshot) {
              if (streamSnapshot.hasData) {
                return const MainHomeScreen();
              } else {
                return const WelcomeScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
