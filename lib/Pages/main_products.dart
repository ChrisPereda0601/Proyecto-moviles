import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tienda_online/bloc/store_bloc.dart';
import 'package:tienda_online/services/firebase_services.dart';

Map<String, dynamic> _productDetail = {};
Map<String, dynamic> get getProductDetail => _productDetail;

class Detail {
  void setProductDetail(Map<String, dynamic> productDetail) {
    _productDetail = productDetail;
  }
}

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
              _productDetail = snapshot.data?[randomProduct];
              BlocProvider.of<StoreBloc>(context).add(ShowDetailProduct());
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
              _productDetail = snapshot.data?[randomProduct];
              BlocProvider.of<StoreBloc>(context).add(ShowDetailProduct());
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
  List<Widget> gestureDetectors = [];
  for (int i = 0; i < 6; i++) gestureDetectors.add(productGestureDetector());

  List<Widget> gestureDetectorsH = [];
  for (int i = 0; i < 6; i++) gestureDetectorsH.add(productGestureDetectorH());

  return Container(
    height: MediaQuery.of(context).size.height,
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
                    labelText: 'Search',
                    icon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                  controller: _productSearched,
                  onSubmitted: (String product) {
                    BlocProvider.of<StoreBloc>(context).add(SearchEvent());
                  },
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.6,
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
          ],
        ),
      ),
    ),
  );
}
