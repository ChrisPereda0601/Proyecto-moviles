import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tienda_online/bloc/store_bloc.dart';
import 'package:tienda_online/services/firebase_services.dart';
import 'package:tienda_online/Pages/orderDetailPage.dart';

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

        print('Órdenes: $orders');

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Esta es tu lista de pedidos',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: orders.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  Map<String, dynamic> orderItem = orders[index];
                  Map<String, dynamic> firstProduct =
                      (orderItem['products'] as List<Map<String, dynamic>>)
                          .first;
                  return InkWell(
                      onTap: () {
                        // Navegar a la nueva página y pasar los detalles de la orden
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OrderDetailPage(orderDetailsList: orderItem),
                          ),
                        );
                      },
                      child: Container(
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
                                  height: 150,
                                  child: GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<StoreBloc>(context)
                                          .add(ShowOrderProduct());
                                    },
                                    child: Column(
                                      children: [
                                        FutureBuilder(
                                          future: getImageUrl(
                                              firstProduct['image']),
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
                                        SizedBox(height: 10),
                                        Wrap(children: [
                                          Text(
                                            'Ver estado->',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    46, 38, 161, 1)),
                                          )
                                        ]),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${firstProduct['name']}...',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '\$${firstProduct['price']}',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold),
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
                                      return Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  '\n Cantidad de productos: ${firstProduct['quantity']}',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  '\n\n\n\n\n   Ver detalles de la orden ->',
                                              style: TextStyle(
                                                  color: const Color.fromRGBO(
                                                      46, 38, 161, 1)),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ));
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
