import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_booking_app/src/bloc/auth/authentication/authentication_bloc.dart';
import 'package:restaurant_booking_app/src/repositories/user_repository.dart';
import 'package:restaurant_booking_app/src/screen/home_screen.dart';
import 'package:restaurant_booking_app/src/screen/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_booking_app/src/utils/constant.dart';
import 'package:restaurant_booking_app/src/widget/loading_page.dart';

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
    return  const MaterialApp(
      title: Constant.appName,
      debugShowCheckedModeBanner: false,
      home: BlocNavigation(),
    );
  }
}

class BlocNavigation extends StatelessWidget {
  const BlocNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if(state is AuthenticationAuthenticated){
          return const HomeScreen();
        }
        else if(state is AuthenticationNotAuthenticated){
          return const LoginForm();
        }
        else {
          return const LoadingPage();
        }

      },
    );
  }
}
