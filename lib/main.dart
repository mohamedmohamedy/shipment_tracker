import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/strings/strings_class.dart';
import 'features/authentication/presentation/bloc/authentication_bloc.dart';
import 'features/shipment/presentation/bloc/shipment_bloc.dart';
import 'features/submit/presentation/bloc/submit_bloc.dart';
import 'features/submit/presentation/screens/form.dart';
import 'features/tracker/presentation/bloc/tracker_bloc.dart';
import 'my_observer.dart';
import 'dependency_container.dart' as di;
import 'features/authentication/presentation/screens/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();

  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: MyObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<AuthenticationBloc>()),
        BlocProvider(create: (context) => di.sl<SubmitBloc>()),
        BlocProvider(
            create: (context) =>
                di.sl<ShipmentBloc>()..add(GetAllShipmentsEvent())),
        BlocProvider(
            create: (context) =>
                di.sl<TrackerBloc>()..add(GetAllTrackersEvent())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: MainStrings.mainTitle,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginScreen(),
        routes: {
          LoginScreen.routeName: (context) => const LoginScreen(),
          FormScreen.routeName: (context) => const FormScreen(),
        },
      ),
    );
  }
}
