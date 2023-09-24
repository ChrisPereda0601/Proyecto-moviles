import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
        backgroundColor: Color.fromRGBO(46, 38, 161, 1),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Nombre/s",
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Apellidos",
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Correo electronico",
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Contraseña",
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Fecha de nacimiento",
            ),
          ),
          MaterialButton(
            onPressed: () {},
            color: Color.fromRGBO(46, 38, 161, 1),
            child: Text(
              "Register",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }
}
