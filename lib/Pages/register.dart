import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tienda_online/bloc/store_bloc.dart';
// import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

Form registerForm(BuildContext context) {
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
          TextFormField(
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
          // RaisedButton(
          //   onPressed: _submitForm,
          // child:
          Text('Login'),
          // ),
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
