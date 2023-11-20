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
    future: getUserOrder(),
    builder: ((context, snapshot) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      if (snapshot.hasData && snapshot.data?.isNotEmpty == true) {
        List<Map<String, dynamic>> orders =
            snapshot.data as List<Map<String, dynamic>>;

        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: orders.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  Map<String, dynamic> orderItem = orders[index];

                  return Container(
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      margin: EdgeInsets.all(8.0),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<StoreBloc>(context)
                                      .add(ShowOrderProduct());
                                },
                                child: FutureBuilder(
                                  future: getImageUrl(orderItem['image']),
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
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${orderItem['name']}...',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  Text(
                                    '\$${orderItem['price']}',
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                ],
                              ),
                            ),
                            // Cantiadad
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
                                    'Cantidad de productos: ${orderItem['quantity']}',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Text(
              '¡Haz llegado al final de tu lista de pedidos!',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Divider(),
          ],
        );
      } else {
        return Card();
      }
    }),
  );
}
