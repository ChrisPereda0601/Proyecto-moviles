import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tienda_online/bloc/store_bloc.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:tienda_online/services/firebase_services.dart';

Future<List> productsQuantity() async {
  List ids = await getUserCartQuantity();
  return ids;
}

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
                      BlocProvider.of<StoreBloc>(context)
                          .add(ShowDetailProduct(snapshot.data?[i]));
                    },
                    child: FutureBuilder(
                      future: getImageUrl(snapshot.data?[i]['image']),
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
                    width: 60.0,
                    height: 30.0,
                    child: ElevatedButton(
                      onPressed: () async {
                        await deleteFromCart(snapshot.data?[i]['id']);
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
                            'Cantidad: ${snapshot.data?[i]}',
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
                        await addToCart(snapshot.data?[i]['id']);
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

Future<int> CartLength() async {
  List total = await getUserCart();
  return total.length;
}

Widget CartContent(BuildContext context) {
  int _currentIndex = 0;
  return FutureBuilder<int>(
    future: CartLength(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        int cartLength = snapshot.data ?? 0;

        List<Widget> cartProducts = [];
        for (int i = 0; i < cartLength; i++) cartProducts.add(CartProducts(i));
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
            Expanded(
              child: ListView(
                children: cartProducts,
              ),
            ),
            FutureBuilder<num>(
              future: PriceTotal(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 60,
                          width: 130,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 27, 144, 180),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              "Total: \$${snapshot.data}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    List<dynamic> cartProducts = await getUserCart();
                    List<Map<String, dynamic>> typedCartProducts =
                        List<Map<String, dynamic>>.from(cartProducts);
                    if (cartProducts.isNotEmpty == true) {
                      try {
                        await createOrder(typedCartProducts);
                        await clearUserCart();
                        BlocProvider.of<StoreBloc>(context)
                            .emit(StoreUpdateState());
                      } catch (e) {
                        print("Error al crear la orden: $e");
                      }
                    }
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => PaypalCheckout(
                        sandboxMode: true,
                        clientId:
                            "Ae5yu_1YTFRIUbx210ojdzwSFW2fZl8gPUyk9AvWMp-HoXqJpoamsmrUBFCR5F_mB1OifMdxOJ4uvmo6",
                        secretKey:
                            "EN0lddmvqyvk-R2irxHgX8CdpyylFY3hD9vB9CSNk7pOT30fT_EvrSShDB-Lfdq7C37Op7JerkpGH2kM",
                        returnURL: "success.snippetcoder.com",
                        cancelURL: "cancel.snippetcoder.com",
                        transactions: const [
                          {
                            "amount": {
                              "total": '70',
                              "currency": "USD",
                              "details": {
                                "subtotal": '70',
                                "shipping": '0',
                                "shipping_discount": 0
                              }
                            },
                            "description":
                                "The payment transaction description.",
                            "item_list": {
                              "items": [
                                {
                                  "name": "Apple",
                                  "quantity": 4,
                                  "price": '5',
                                  "currency": "USD"
                                },
                                {
                                  "name": "Pineapple",
                                  "quantity": 5,
                                  "price": '10',
                                  "currency": "USD"
                                }
                              ],
                            }
                          }
                        ],
                        note: "Contact us for any questions on your order.",
                        onSuccess: (Map params) async {
                          print("onSuccess: $params");
                        },
                        onError: (error) {
                          Navigator.pop(context);
                          print("onError: $error");
                        },
                        onCancel: () {
                          print('cancelled:');
                        },
                      ),
                    ));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 36, 181, 225),
                    ),
                  ),
                  child: Text(
                    "Confirmar compra",
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await clearUserCart();
                      BlocProvider.of<StoreBloc>(context)
                          .emit(StoreDeleteState());
                    } catch (e) {
                      print("Error al vaciar el carrito: $e");
                    }
                  },
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
            BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                _currentIndex = index;

                _onTabTapped(index, context);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Inicio',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Buscar',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Carrito',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Pedidos',
                ),
              ],
              selectedLabelStyle: TextStyle(color: Colors.black),
              unselectedLabelStyle: TextStyle(color: Colors.black54),
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black54,
            ),
          ],
        );
      } else {
        return CircularProgressIndicator();
      }
    },
  );
}

void _onTabTapped(int index, context) {
  switch (index) {
    case 0:
      BlocProvider.of<StoreBloc>(context).add(GetProductsEvent());
      break;
    case 1:
      BlocProvider.of<StoreBloc>(context).add(SearchEvent());
      break;
    case 2:
      BlocProvider.of<StoreBloc>(context).add(ViewCarEvent());
      break;
    case 3:
      BlocProvider.of<StoreBloc>(context).add(ViewOrdersEvent());
      break;
  }
}
