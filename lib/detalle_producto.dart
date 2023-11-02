import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tienda_online/bloc/store_bloc.dart';
import 'package:tienda_online/carrito_detalle.dart';
import 'package:tienda_online/login.dart';

class DetalleProducto extends StatelessWidget {
  const DetalleProducto({super.key});

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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Image.asset(
                "assets/images/bocina.jpg",
                width: 300,
                height: 300,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16, bottom: 16),
              child: Row(
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
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: Color.fromARGB(255, 214, 237, 255),
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(
                          10), //Padding entre container y sus elementos.
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 300,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 36, 181, 225)),
                                ),
                                child: Text("Agregar a carrito"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: Color.fromARGB(255, 214, 237, 255),
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(
                          10), //Padding entre container y sus elementos.
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 300,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {
                                  Producto producto = Producto(
                                    nombre: "Tank Top", // Nombre del producto
                                    precio: 259.5, // Precio del producto
                                    cantidad:
                                        1, // Cantidad (puedes ajustarla según tus necesidades)
                                  );
                                  // Agregar el producto al carrito
                                  carrito.add(producto);

                                  // Mostrar un mensaje de éxito o realizar alguna otra acción
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text("Producto agregado al carrito"),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 36, 181, 225)),
                                ),
                                child: Text("Agregar a carritow"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text(
                  "Detalles de producto",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            ),
            Divider(),
            Text(
                "Bocina bluetooth inalámbrica TXG Bocina Bluetooth Portátil, Duales Altavoz Inalámbrico Bluetooth 5.0 con Sonido Estéreo HD, Bajos Profundos"),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CarritoDetalle(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 36, 181, 225)),
                  ),
                  child: Text("Ver carrito"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _defaultFormState(BuildContext? blocContext) {
    return ListView(
      children: [
        ElevatedButton(
          onPressed: () {
            BlocProvider.of<StoreBloc>(blocContext!)
                .add(SaveProductToStorageEvent());
          },
          child: Text("Guardar nota"),
        ),
      ],
    );
  }
}
