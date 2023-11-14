import 'package:flutter/material.dart';
import 'package:tienda_online/home_page.dart';

//Bloc imports
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tienda_online/bloc/store_bloc.dart';

//Firebase imports
import 'package:firebase_core/firebase_core.dart';
import 'package:tienda_online/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    BlocProvider(
      create: (context) => StoreBloc(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: BlocProvider(
        create: (context) => StoreBloc()..add(GetProductsEvent()),
        child: HomePage(),
      ),
    );
  }
}
