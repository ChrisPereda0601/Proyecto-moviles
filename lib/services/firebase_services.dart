import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getProducts() async {
  List products = [];
  CollectionReference referenceProducts = db.collection('products');

  QuerySnapshot queryProducts = await referenceProducts.get();

  queryProducts.docs.forEach((product) {
    products.add(product.data());
  });
  print(products.length);

  return products;
}
