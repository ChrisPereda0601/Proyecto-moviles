import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tienda_online/bloc/store_bloc.dart';
import 'package:tienda_online/services/firebase_services.dart';
import 'package:tienda_online/services/firebase_services_auth.dart';

TextEditingController _passwordController = TextEditingController();
TextEditingController _emailController = TextEditingController();

final FirebaseAuthService _auth = FirebaseAuthService();

Form LoginForm(BuildContext context) {
  return Form(
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            'Login',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _signIn(context);
            },
            child: Text('Log in'),
          ),
          TextButton(
              onPressed: () {
                BlocProvider.of<StoreBloc>(context).add(RegisterEvent());
              },
              child: Text('Sign in?'))
        ],
      ),
    ),
  );
}

void _signIn(BuildContext context) async {
  String email = _emailController.text;
  String password = _passwordController.text;

  User? user = await _auth.signIn(email, password);

  if (user != null) {
    currentUser(user.uid);
    BlocProvider.of<StoreBloc>(context).add(GetProductsEvent());
  }
}
