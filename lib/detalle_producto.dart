import 'package:flutter/material.dart';

class DetalleProducto extends StatelessWidget {
  const DetalleProducto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GlamourOnlineStore'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://www.tuexperto.com/wp-content/uploads/2022/06/novedades-shein.jpg.webp",
                width: 300,
                height: 300,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text("Tank Top"),
                ],
              ),
              Column(
                children: [
                  Text("\$259.5"),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  leading: Icon(Icons.remove),
                  // Text("5"),
                  // Icon(Icons.add),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: Text("Add"),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
