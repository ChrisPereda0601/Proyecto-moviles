import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tienda_online/bloc/store_bloc.dart';
import 'package:tienda_online/services/firebase_services.dart';
import 'package:tienda_online/services/firebase_services_auth.dart';

TextEditingController _usernameController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _addressController = TextEditingController();

final FirebaseAuthService _auth = FirebaseAuthService();

Form registerForm(BuildContext context) {
  return Form(
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                BlocProvider.of<StoreBloc>(context).add(LoginEvent());
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
          Text(
            'Register',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextFormField(
            controller: _emailController,
            decoration:
                InputDecoration(labelText: 'Email (must contain @email)'),
          ),
          TextFormField(
            controller: _passwordController,
            decoration:
                InputDecoration(labelText: 'Password (at least 6 characters)'),
            obscureText: true,
          ),
          TextFormField(
            controller: _addressController,
            decoration: InputDecoration(labelText: 'Address'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _signUp(context);
            },
            child: Text('Sign up'),
          ),
        ],
      ),
    ),
  );
}

void _signUp(BuildContext context) async {
  String username = _usernameController.text;
  String email = _emailController.text;
  String password = _passwordController.text;
  String address = _addressController.text;

  User? user = await _auth.signUp(email, password);

  if (user != null) {
    createUser(user, username, user.email!, address);
    BlocProvider.of<StoreBloc>(context).add(LoginEvent());
  }
}
