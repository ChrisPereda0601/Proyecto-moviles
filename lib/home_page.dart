import 'package:flutter/material.dart';
import 'package:tienda_online/detalle_producto.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GlamourOnlineStore'),
      ),
      body: Column(children: [
        Text('Hello World'),
        MaterialButton(
          child: Text('Go to second page'),
          color: Colors.yellow,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetalleProducto(),
              ),
            );
          },
        ),
      ]),
    );
  }
}
