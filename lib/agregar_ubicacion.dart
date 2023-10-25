import 'package:flutter/material.dart';
import 'package:tienda_online/carrito_detalle.dart';
import 'package:tienda_online/detalle_producto.dart';
import 'package:tienda_online/home_page.dart';

class AgragaUbicacion extends StatelessWidget {
  const AgragaUbicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubicacion de pedido'),
        backgroundColor: Color.fromRGBO(46, 38, 161, 1),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DetalleProducto()));
              },
              icon: Icon(Icons.arrow_back)),
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              },
              icon: Icon(Icons.home))
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Calle"),
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Numero"),
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Codigo Postal"),
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Referencias"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CarritoDetalle()));
                      },
                      child: Text("Guardar"),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop(context);
                      },
                      child: Text("Cancelar"),
                    ),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
