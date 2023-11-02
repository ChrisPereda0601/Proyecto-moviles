import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tienda_online/bloc/store_bloc.dart';

// import 'package:tienda_online/detalle_producto.dart';
// import 'package:tienda_online/search_results.dart';

//Pages
import 'package:tienda_online/Pages/search_results.dart' as resultsPage;
import 'package:tienda_online/Pages/main_products.dart' as mainPage;
import 'package:tienda_online/Pages/cart.dart' as cartPage;
import 'package:tienda_online/Pages/detalle_producto.dart' as productPage;

//Firebase imports
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'package:tienda_online/firebase_options.dart';
// import 'package:tienda_online/services/firebase_services.dart';

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
        title: Text('ITEStore'),
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
            return mainPage.VerticalContent(context);
          } else if (state is StoreSearchState) {
            return resultsPage.SearchResults(context, _productSearched);
          } else if (state is StoreDetailState) {
            return productPage.detalleProducto(context);
          } else if (state is StoreCarState) {
            return cartPage.cartContent(context);
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
}
