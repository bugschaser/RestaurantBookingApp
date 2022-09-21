import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_booking_app/src/bloc/auth/authentication/authentication_bloc.dart';
import 'package:restaurant_booking_app/src/repositories/user_repository.dart';
import 'package:restaurant_booking_app/src/screen/home_screen.dart';
import 'package:restaurant_booking_app/src/screen/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_booking_app/src/utils/constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();

  await Firebase.initializeApp();
  // runApp(const MyApp());
  runApp(MultiProvider(
    providers: [
      RepositoryProvider(create: (context) => UserRepository()),
    ],
    child: Builder(builder: (context) {
      return BlocProvider(
        create: (context) => AuthenticationBloc(
            userRepository: RepositoryProvider.of<UserRepository>(context))..add(AppStarted()),
        child: const MyApp(),
      );
    }),
  ));
}

class AppBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint(transition.toString());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: Constant.appName,
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {

          return (state is AuthenticationAuthenticated)? const HomeScreen() : const LoginForm();
        },
      ),
    );
  }
}

