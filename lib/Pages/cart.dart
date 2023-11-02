import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tienda_online/bloc/store_bloc.dart';
// import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:tienda_online/Pages/detalle_producto.dart'
    as productPage; // import 'package:tienda_online/estado_entrega.dart';
import 'package:tienda_online/estado_entrega.dart';
import 'package:tienda_online/services/firebase_services.dart';

Widget CartProducts(int i) {
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              productPage.detalleProducto(context),
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
                          snapshot.data?[i]['name'],
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '\$${snapshot.data?[i]['price']}',
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
                    'Cantidad: ${snapshot.data?[i]['quantity']}',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  // Agregar
                  SizedBox(
                    width: 60.0, // Ancho deseado
                    height: 30.0, // Alto deseado
                    child: ElevatedButton(
                      onPressed: () {
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

Future<num> PriceTotal() async {
  num total = await getUserCartTotal();
  print("total: $total");
  return total;
}

Widget cartContent(BuildContext context) {
  List<Widget> cartProducts = [];
  for (int i = 0; i < 2; i++) cartProducts.add(CartProducts(i));

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
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () {
              BlocProvider.of<StoreBloc>(context).add(ShowDetailProduct());
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        Expanded(
          child: ListView(
            children: cartProducts,
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
                    "Total: \$${PriceTotal()}",
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
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     ElevatedButton(
        //       //Cuenta para paypal
        //       //Usuario: sb-1y6fe27160910@personal.example.com
        //       //password: mPe)C6Mk
        //       onPressed: () async {
        //         Navigator.of(context).push(MaterialPageRoute(
        //       builder: (BuildContext context) => PaypalCaheckout(
        //       sandboxMode: true,
        //       clientId: "Ae5yu_1YTFRIUbx210ojdzwSFW2fZl8gPUyk9AvWMp-HoXqJpoamsmrUBFCR5F_mB1OifMdxOJ4uvmo6",
        //       secretKey: "EN0lddmvqyvk-R2irxHgX8CdpyylFY3hD9vB9CSNk7pOT30fT_EvrSShDB-Lfdq7C37Op7JerkpGH2kM",
        //       returnURL: "success.snippetcoder.com",
        //       cancelURL: "cancel.snippetcoder.com",
        //       transactions: const [
        //         {
        //           "amount": {
        //             "total": '70',
        //             "currency": "USD",
        //             "details": {
        //               "subtotal": '70',
        //               "shipping": '0',
        //               "shipping_discount": 0
        //             }
        //           },
        //           "description": "The payment transaction description.",
        //           // "payment_options": {
        //           //   "allowed_payment_method":
        //           //       "INSTANT_FUNDING_SOURCE"
        //           // },
        //           "item_list": {
        //             "items": [
        //               {
        //                 "name": "Apple",
        //                 "quantity": 4,
        //                 "price": '5',
        //                 "currency": "USD"
        //               },
        //               {
        //                 "name": "Pineapple",
        //                 "quantity": 5,
        //                 "price": '10',
        //                 "currency": "USD"
        //               }
        //             ],

        //             // shipping address is not required though
        //             //   "shipping_address": {
        //             //     "recipient_name": "Raman Singh",
        //             //     "line1": "Delhi",
        //             //     "line2": "",
        //             //     "city": "Delhi",
        //             //     "country_code": "IN",
        //             //     "postal_code": "11001",
        //             //     "phone": "+00000000",
        //             //     "state": "Texas"
        //             //  },
        //           }
        //         }
        //       ],
        //       note: "Contact us for any questions on your order.",
        //       onSuccess: (Map params) async {
        //         print("onSuccess: $params");
        //       },
        //       onError: (error) {
        //         print("onError: $error");
        //         Navigator.pop(context);
        //       },
        //       onCancel: () {
        //         print('cancelled:');
        //       },
        //     ),
        //   ));
        //       },
        //       style: ButtonStyle(
        //         backgroundColor: MaterialStateProperty.all<Color>(
        //           Color.fromARGB(255, 36, 181, 225),
        //         ),
        //       ),
        //       child: Text("Confirmar compra"),
        //     ),
        //   ],
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     ElevatedButton(
        //       onPressed: () {},
        //       style: ButtonStyle(
        //         backgroundColor: MaterialStateProperty.all<Color>(
        //           Color.fromARGB(255, 36, 181, 225),
        //         ),
        //       ),
        //       child: Text(
        //         "Vaciar carrito",
        //       ),
        //     ),
        //   ],
        // ),
      ],
    ),
  );
}
