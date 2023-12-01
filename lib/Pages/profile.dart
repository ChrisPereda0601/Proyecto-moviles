import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tienda_online/bloc/store_bloc.dart';
import 'package:tienda_online/services/firebase_services.dart';

TextEditingController _productSearched = TextEditingController();
TextEditingController get getProductSearched => _productSearched;

Widget ProfileContent(BuildContext context) {
  return FutureBuilder(
    future: getUserInfo(),
    builder: ((context, snapshot) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      if (snapshot.hasData) {
        return Container(
          width: double.infinity, // Take up the full width
          height: double.infinity, // Take up the full height
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: Text(
                      '${snapshot.data?['name'][0]}',
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Usuario: ${snapshot.data?['name']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Dirección: ${snapshot.data?['address']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Correo: ${snapshot.data?['e-mail']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () {
                      signOut(context);
                    },
                    child: Text('Log out'),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return Card();
      }
    }),
  );
}

void signOut(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    print("User logged out successfully");
    BlocProvider.of<StoreBloc>(context).add(LoginEvent());
  } catch (e) {
    print("Error logging out: $e");
  }
}
