import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tienda_online/Pages/main_products.dart';
import 'package:tienda_online/bloc/store_bloc.dart';
import 'package:tienda_online/services/firebase_services.dart';

Widget SearchResults(BuildContext context) {
  return SingleChildScrollView(
    child: Container(
        child: FutureBuilder<List<Widget>>(
            future: SeacrhContent(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              BlocProvider.of<StoreBloc>(context)
                                  .add(GetProductsEvent());
                            },
                            icon: Icon(Icons.arrow_back_ios_new_rounded),
                          ),
                          Text(
                            '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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
                          controller: getProductSearched,
                          onSubmitted: (String product) {
                            BlocProvider.of<StoreBloc>(context)
                                .add(SearchEvent());
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 1.3,
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: ListView(
                        children: snapshot.data ?? [],
                      ),
                    ),
                  ],
                );
              }
            })),
  );
}

Future<List<Widget>> SeacrhContent(BuildContext context) async {
  List<Widget> searchResults = [];
  List<dynamic> products = await getProducts();

  products.forEach(
    (product) {
      if (product['name']
              .toLowerCase()
              .contains(getProductSearched.text.toLowerCase()) ||
          product['description']
              .toLowerCase()
              .contains(getProductSearched.text.toLowerCase())) {
        searchResults.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<StoreBloc>(context)
                    .add(ShowDetailProduct(product));
              },
              child: Container(
                height: 120,
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
                          future: getImageUrl(product['image']),
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
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Wrap(
                                children: [
                                  Text(
                                    product['name'],
                                    style: TextStyle(fontSize: 18),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Wrap(
                                children: [
                                  Text(
                                    product['description'],
                                    style: TextStyle(fontSize: 15),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Precio: ${product['price']}',
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
          ),
        );
      }
    },
  );
  return searchResults;
}
