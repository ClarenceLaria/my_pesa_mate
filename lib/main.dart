import 'package:flutter/material.dart';
import 'package:face_camera/face_camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurerefinancialplanner_app/bloc/add_transaction/add_transaction_bloc.dart';
import 'package:kurerefinancialplanner_app/bloc/transaction/transaction_bloc.dart';
import 'package:kurerefinancialplanner_app/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FaceCamera.initialize();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AddTransactionBloc()),
        BlocProvider(create: (_) => TransactionBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Pesa Mate',
      theme: ThemeData(
        fontFamily: 'SFPro',
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
