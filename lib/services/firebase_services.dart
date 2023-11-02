import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getProducts() async {
  List products = [];
  CollectionReference referenceProducts = db.collection('products');

  QuerySnapshot queryProducts = await referenceProducts.get();

  queryProducts.docs.forEach((product) {
    products.add(product.data());
  });

  return products;
}

Future<List> getUserCart() async {
  String userID = 'pc3EWbYjinPMHdTNMlOD';

  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  DocumentSnapshot<Object?> userInfo = await userCollection.doc(userID).get();

  Map<String, dynamic> data = userInfo.data() as Map<String, dynamic>;
  Map cart = data['cart'];

  CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');
  DocumentSnapshot<Object?> product;
  List products = [];

  for (var productId in cart.keys) {
    product = await productsCollection.doc(productId).get();
    products.add(product.data());
  }

  return products;
}

Future<List> getUserCartQuantity() async {
  String userID = 'pc3EWbYjinPMHdTNMlOD';

  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  DocumentSnapshot<Object?> userInfo = await userCollection.doc(userID).get();

  Map<String, dynamic> data = userInfo.data() as Map<String, dynamic>;
  Map cart = data['cart'];
  List productsQuantity = [];

  for (var productQuan in cart.values) {
    productsQuantity.add(productQuan);
  }

  return productsQuantity;
}

Future<num> getUserCartTotal() async {
  String userID = 'pc3EWbYjinPMHdTNMlOD';

  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  DocumentSnapshot<Object?> userInfo = await userCollection.doc(userID).get();

  Map<String, dynamic> data = userInfo.data() as Map<String, dynamic>;
  Map cart = data['cart'];

  CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');
  DocumentSnapshot<Object?> product;
  num productsTotal = 0;
  num price = 0;

  for (var productId in cart.keys) {
    product = await productsCollection.doc(productId).get();
    price = product['price'] as num;
    print(price);
    productsTotal += price;
  }

  return productsTotal;
}
