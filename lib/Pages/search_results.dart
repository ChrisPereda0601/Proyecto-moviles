import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tienda_online/bloc/store_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tienda_online/bloc/store_bloc.dart';
// import 'package:tienda_online/Pages/detalle_producto.dart'
// as productPage; // import 'package:tienda_online/search_results.dart';

//Firebase imports
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'package:tienda_online/firebase_options.dart';
import 'package:tienda_online/services/firebase_services.dart';

Widget SearchResults(BuildContext context, String productSearched) {
  List<Widget> listViewResults = [];
  for (int i = 0; i < 6; i++) listViewResults.add(SeacrhContent());
  return Container(
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  BlocProvider.of<StoreBloc>(context).add(GetProductsEvent());
                },
                icon: Icon(Icons.arrow_back_ios_new_rounded),
              ),
              Text(
                '',
                // 'Buscando: ${SearchEvent.product}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 1.3,
          padding: EdgeInsets.only(left: 15, right: 15),
          child: ListView(
            children: listViewResults,
          ),
        ),
      ],
    ),
  );
}

Widget SeacrhContent() {
  return FutureBuilder(
    future: getProducts(),
    builder: ((context, snapshot) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      if (snapshot.hasData) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              BlocProvider.of<StoreBloc>(context).add(ShowDetailProduct());
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
                      child: Image.asset(
                        'assets/images/bocina.jpg',
                        width: MediaQuery.of(context).size.width / 4,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            children: [
                              Text(
                                snapshot.data?[0]['name'],
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Wrap(
                            children: [
                              Text(
                                'Bocina bluetooth',
                                style: TextStyle(fontSize: 15),
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
