import 'package:flutter/material.dart';
import 'package:tienda_online/home_page.dart';

//Bloc imports
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tienda_online/bloc/store_bloc.dart';

//Firebase imports
import 'package:firebase_core/firebase_core.dart';
import 'package:tienda_online/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final storeBloc = StoreBloc();

  runApp(
    BlocProvider(
      create: (context) => storeBloc,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}
