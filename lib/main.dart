import 'package:flutter/material.dart';
import 'package:tienda_online/home_page.dart';

//Bloc imports
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tienda_online/bloc/store_bloc.dart';

//Firebase imports
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
import 'package:tienda_online/firebase_options.dart';
import 'package:tienda_online/services/firebase_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<StoreBloc, StoreState>(
    //   builder: (context, state) {
    return MaterialApp(
      title: 'Material App',
      home: BlocProvider(
        create: (context) => StoreBloc()..add(GetProductsEvent()),
        child: HomePage(),
      ),
      // );
      // },
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prueba'),
      ),
      body: FutureBuilder(
        future: getProducts(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Text(snapshot.data?[index]['name']);
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
