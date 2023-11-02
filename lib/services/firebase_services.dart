import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tienda_online/models/product.dart';

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

Future<DocumentSnapshot<Object?>> getSpecificProduct() async {
  CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');
  DocumentSnapshot<Object?> product;

  product = await productsCollection.doc('I1jmjgHZTUGDi3k3Wnz6').get();

  return product;
}

Future<void> addToCart(int quantity) async {
  String userID = 'pc3EWbYjinPMHdTNMlOD';

  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  DocumentSnapshot<Object?> userInfo = await userCollection.doc(userID).get();

  Map<String, dynamic> data = userInfo.data() as Map<String, dynamic>;

  // Verifica si el usuario ya tiene un carrito
  if (data.containsKey('cart')) {
    Map<String, dynamic> cart = data['cart'];
    if (cart.containsKey('I1jmjgHZTUGDi3k3Wnz7')) {
      // Si el producto ya está en el carrito, actualiza la cantidad
      cart['I1jmjgHZTUGDi3k3Wnz7'] =
          (cart['I1jmjgHZTUGDi3k3Wnz7'] as int) + quantity;
      print("Se llegó aquí");
    } else {
      // Si el producto no está en el carrito, agrégalo
      cart['I1jmjgHZTUGDi3k3Wnz7'] = quantity;
    }
  } else {
    // Si el usuario no tiene un carrito, crea uno nuevo
    data['cart'] = {'I1jmjgHZTUGDi3k3Wnz7': quantity};
  }

  // Actualiza el carrito en la base de datos
  await userCollection
      .doc(userID)
      .set({'cart': data['cart']}, SetOptions(merge: true));
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
