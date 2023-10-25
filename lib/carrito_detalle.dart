import 'package:flutter/material.dart';
import 'package:tienda_online/detalle_producto.dart';
import 'package:tienda_online/estado_entrega.dart';

class CarritoDetalle extends StatefulWidget {
  const CarritoDetalle({super.key});

  @override
  State<CarritoDetalle> createState() => _CarritoDetalleState();
}

class _CarritoDetalleState extends State<CarritoDetalle> {
  double _total = 0;

  List<Producto> carrito = [
    Producto(
      nombre: 'Producto 1',
      precio: 20.0,
      cantidad: 2,
    ),
    Producto(
      nombre: 'Producto 2',
      precio: 30.0,
      cantidad: 1,
    ),
    Producto(
      nombre: 'Producto 3',
      precio: 50.0,
      cantidad: 3,
    ),
    Producto(
      nombre: 'Producto 4',
      precio: 50.0,
      cantidad: 2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ITEStore'),
        backgroundColor: Color.fromRGBO(46, 38, 161, 1),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: IconButton(
              icon: Icon(Icons.person),
              tooltip: "Log In",
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => Login(),
                //   ),
                // );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: carrito.length,
              itemBuilder: (context, index) {
                final producto = carrito[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetalleProducto(),
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/images/bocina.jpg',
                            width: 80.0,
                            height: 80.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                producto.nombre,
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Text(
                                '\$${producto.precio}',
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                        // Eliminar
                        SizedBox(
                          width: 60.0, // Ancho deseado
                          height: 30.0, // Alto deseado
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 36, 181, 225)),
                            ),
                            child: Icon(Icons.remove),
                          ),
                        ),
                        // Cantidad
                        Text(
                          'Cantidad: ${producto.cantidad}',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        // Agregar
                        SizedBox(
                          width: 60.0, // Ancho deseado
                          height: 30.0, // Alto deseado
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 36, 181, 225)),
                            ),
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 27, 144, 180),
                      borderRadius: BorderRadius.circular(
                          10.0) // Añadir esquinas redondeadas
                      ),
                  child: Center(
                    child: Text(
                      "Total: ${calculateTotal()}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EstadoEntrega(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 36, 181, 225),
                  ),
                ),
                child: Text("Confirmar compra"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 36, 181, 225),
                  ),
                ),
                child: Text(
                  "Vaciar carrito",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double calculateTotal() {
    for (int i = 0; i < carrito.length; i++) {
      Producto product = carrito[i];
      _total += (product.precio * product.cantidad);
    }
    return _total;
  }
}

class Producto {
  final String nombre;
  final double precio;
  int cantidad;

  Producto({
    required this.nombre,
    required this.precio,
    required this.cantidad,
  });
}
