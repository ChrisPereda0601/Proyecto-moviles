import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tienda_online/bloc/store_bloc.dart';
import 'package:tienda_online/services/firebase_services.dart';

Widget detalleProducto(BuildContext context) {
  return FutureBuilder(
    future: getSpecificProduct(),
    builder: ((context, snapshot) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      if (snapshot.hasData) {
        return Column(
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
            Padding(
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
                            Text(
                              "${snapshot.data?['name']}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "\$${snapshot.data?['price']}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
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
                                      onPressed: () {
                                        addToCart();
                                        print("Se agregó uno al carrito");
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color.fromARGB(
                                                    255, 36, 181, 225)),
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
                    "${snapshot.data?['description']}",
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<StoreBloc>(context)
                              .add(ViewCarEvent());
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
          ],
        );
      } else {
        return Card();
      }
    }),
  );
}
