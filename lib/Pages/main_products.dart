import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tienda_online/bloc/store_bloc.dart';
import 'package:tienda_online/services/firebase_services.dart';

TextEditingController _productSearched = TextEditingController();
TextEditingController get getProductSearched => _productSearched;

Widget productGestureDetector() {
  return FutureBuilder(
    future: getProducts(),
    builder: ((context, snapshot) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      if (snapshot.hasData) {
        Random random = Random();
        int randomProduct = random.nextInt(10);
        return Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width / 3,
          child: GestureDetector(
            onTap: () {
              BlocProvider.of<StoreBloc>(context)
                  .add(ShowDetailProduct(snapshot.data?[randomProduct]));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Text(
                          snapshot.data?[randomProduct]['name'],
                          style: TextStyle(fontSize: 24),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: FutureBuilder(
                          future: getImageUrl(
                              snapshot.data?[randomProduct]['image']),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else {
                              return Image.network(
                                snapshot.data.toString(),
                                width: MediaQuery.of(context).size.width / 5,
                                height: MediaQuery.of(context).size.width / 5,
                                fit: BoxFit.fill,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Text(
                          snapshot.data?[randomProduct]['description'],
                          style: TextStyle(fontSize: 15),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return GestureDetector();
      }
    }),
  );
}

Widget productGestureDetectorH() {
  return FutureBuilder(
    future: getProducts(),
    builder: ((context, snapshot) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      if (snapshot.hasData) {
        Random random = Random();
        int randomProduct = random.nextInt(10);
        return Container(
          height: MediaQuery.of(context).size.height / 5,
          width: MediaQuery.of(context).size.width / 1.5,
          child: GestureDetector(
            onTap: () {
              BlocProvider.of<StoreBloc>(context)
                  .add(ShowDetailProduct(snapshot.data?[randomProduct]));
            },
            child: Container(
              height: 80,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 8,
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: FutureBuilder(
                          future: getImageUrl(
                              snapshot.data?[randomProduct]['image']),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Image.network(
                                snapshot.data.toString(),
                                width: MediaQuery.of(context).size.width / 5,
                                height: MediaQuery.of(context).size.width / 5,
                                fit: BoxFit.fill,
                              );
                            }
                          },
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Text(
                                  snapshot.data?[randomProduct]['name'],
                                  style: TextStyle(fontSize: 18),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Precio: \$${snapshot.data?[randomProduct]['price']}',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        return Container(height: 200, width: 200, child: GestureDetector());
      }
    }),
  );
}

Container VerticalContent(BuildContext context) {
  int _currentIndex = 0;
  List<Widget> gestureDetectors = [];
  for (int i = 0; i < 12; i++) gestureDetectors.add(productGestureDetector());

  List<Widget> gestureDetectorsH = [];
  for (int i = 0; i < 6; i++) gestureDetectorsH.add(productGestureDetectorH());

  return Container(
    height: MediaQuery.of(context).size.height,
    child: SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.55,
              child: GridView.count(
                primary: false,
                padding: EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: gestureDetectors,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: gestureDetectorsH,
              ),
            ),
            SingleChildScrollView(
              child: BottomNavigationBar(
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
            ),
          ],
        ),
      ),
    ),
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

//Pantalla para falta de conexión

class ConnectivityService {
  Future<bool> hasConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}

class NoConnectionContent extends StatelessWidget {
  final VoidCallback onRetry;

  NoConnectionContent({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/no-internet.png",
        ),
        Text(
          'No tienes conexión a internet. 🚫',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: 220.0,
          height: 50.0,
          child: ElevatedButton(
            onPressed: onRetry,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 36, 181, 225)),
            ),
            child: Text(
              'Verificar conexión de nuevo',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}
