import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tienda_online/bloc/store_bloc.dart';
import 'package:tienda_online/services/firebase_services_auth.dart';

TextEditingController _passwordController = TextEditingController();
TextEditingController _emailController = TextEditingController();

final FirebaseAuthService _auth = FirebaseAuthService();

Form loginForm(BuildContext context) {
  return Form(
    // key: _formKey,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                BlocProvider.of<StoreBloc>(context).add(GetProductsEvent());
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
          Text(
            'Login',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            // validator: (value) {
            //   if (value.isEmpty || !value.contains('@')) {
            //     return 'Please enter a valid email address';
            //   }
            //   return null;
            // },
            // onSaved: (value) {
            //   _email = value;
            // },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            // validator: (value) {
            //   if (value.isEmpty || value.length < 6) {
            //     return 'Password must be at least 6 characters';
            //   }
            //   return null;
            // },
            // onSaved: (value) {
            //   _password = value;
            // },
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
    BlocProvider.of<StoreBloc>(context).add(GetProductsEvent());
  }
}
