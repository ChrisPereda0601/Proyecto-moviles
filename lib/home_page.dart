import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tienda_online/bloc/store_bloc.dart';
import 'package:tienda_online/detalle_producto.dart';
// import 'package:tienda_online/search_results.dart';

//Pages
import 'package:tienda_online/Pages/search_results.dart' as resultsPage;

//Firebase imports
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'package:tienda_online/firebase_options.dart';
import 'package:tienda_online/services/firebase_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _productSearched = '';
  String get getProductSearched => _productSearched;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GlamourOnlineStore'),
        backgroundColor: Color.fromRGBO(46, 38, 161, 1),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: IconButton(
              icon: Icon(Icons.qr_code),
              tooltip: "Read QR",
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => QR(),
                //   ),
                // );
              },
            ),
          ),
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
      body: BlocBuilder<StoreBloc, StoreState>(
        builder: (context, state) {
          if (state is StoreHomeState) {
            return VerticalContent(context);
          } else if (state is StoreSearchState) {
            return resultsPage.SearchResults(context, _productSearched);
          } else if (state is StoreDetailState) {
            return Container();
          } else if (state is StoreCarState) {
            return Container();
          } else if (state is StoreLoginState) {
            return Container();
          } else if (state is StoreRegisterState) {
            return Container();
          } else if (state is PayState) {
            return Container();
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget productGestureDetector() {
    return FutureBuilder(
      future: getProducts(),
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.hasData) {
          return Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.height / 3,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetalleProducto(),
                  ),
                );
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
                        Text(
                          snapshot.data?[0]['name'],
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.asset(
                            'assets/images/bocina.jpg',
                            width: MediaQuery.of(context).size.width / 5,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.data?[0]['description'],
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container();
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
          return Container(
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.height / 5,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetalleProducto(),
                  ),
                );
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
                        child: Image.asset(
                          'assets/images/bocina.jpg',
                          width: MediaQuery.of(context).size.width / 5,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Text(
                                  snapshot.data?[0]['name'],
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Precio: ${snapshot.data?[0]['price']}',
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
          return Container();
        }
      }),
    );
  }

  Container VerticalContent(BuildContext context) {
    List<Widget> gestureDetectors = [];
    for (int i = 0; i < 6; i++) gestureDetectors.add(productGestureDetector());

    List<Widget> gestureDetectorsH = [];
    for (int i = 0; i < 6; i++)
      gestureDetectorsH.add(productGestureDetectorH());

    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 200, 199, 199),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      icon: Icon(Icons.search),
                      border: InputBorder.none,
                    ),
                    onSubmitted: (String product) {
                      // _productSearched = product;
                      BlocProvider.of<StoreBloc>(context)
                          .add(SearchEvent(product));
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         SearchResult(product_searched: product),
                      //   ),
                      // );
                    },
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.8,
                child: GridView.count(
                  primary: false,
                  padding: EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: gestureDetectors,
                ),
              ),
              //Recomendaciones horizontal

              // child:
              Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width / 2,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: gestureDetectorsH,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
