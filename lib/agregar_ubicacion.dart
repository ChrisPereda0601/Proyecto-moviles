import 'package:flutter/material.dart';

class AgragaUbicacion extends StatelessWidget {
  const AgragaUbicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubicacion de pedido'),
        backgroundColor: Color.fromRGBO(46, 38, 161, 1),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
          IconButton(onPressed: () {}, icon: Icon(Icons.home))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Calle",
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Colonia",
                    ),
                  ),
                  Row(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Num ext",
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Num int",
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Codigo postal",
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: Text("Realizar pedido"),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: Text("Cancelar"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
