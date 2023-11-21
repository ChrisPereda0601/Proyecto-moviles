import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tienda_online/bloc/store_bloc.dart';
import 'package:tienda_online/services/firebase_services.dart';

Future<List> productsQuantity() async {
  List ids = await getUserCartQuantity();
  return ids;
}

Widget Orders(BuildContext context) {
  return FutureBuilder(
    future: getUserCart(),
    builder: ((context, snapshot) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      if (snapshot.hasData) {
        return Container(
          height: MediaQuery.of(context).size.height / 6,
          width: MediaQuery.of(context).size.width,
          child: Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<StoreBloc>(context)
                          .add(ShowDetailProduct(snapshot.data?[0]));
                    },
                    child: FutureBuilder(
                      future: getImageUrl(snapshot.data?[0]['image']),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          return Image.network(
                            snapshot.data.toString(),
                            width: 80.0,
                            height: 80.0,
                            fit: BoxFit.cover,
                          );
                        }
                      },
                    ),
                  ),

                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data?[0]['name'],
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '\$${snapshot.data?[0]['price']}',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ],
                    ),
                  ),
                  // Eliminar
                  SizedBox(
                    width: 60.0,
                    height: 30.0,
                    child: ElevatedButton(
                      onPressed: () async {
                        await deleteFromCart(snapshot.data?[0]['id']);
                        BlocProvider.of<StoreBloc>(context)
                            .add(AddProductEvent());
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 36, 181, 225)),
                      ),
                      child: Icon(Icons.remove),
                    ),
                  ),
                  // Cantidad
                  FutureBuilder<List>(
                      future: productsQuantity(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Text(
                            'Cantidad: ${snapshot.data?[0]}',
                            style: TextStyle(fontSize: 14.0),
                          );
                        }
                      }),
                  // Agregar
                  SizedBox(
                    width: 60.0,
                    height: 30.0,
                    child: ElevatedButton(
                      onPressed: () async {
                        await addToCart(snapshot.data?[0]['id']);
                        BlocProvider.of<StoreBloc>(context)
                            .add(AddProductEvent());
                      },
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
          ),
        );
      } else {
        return Card();
      }
    }),
  );
}
