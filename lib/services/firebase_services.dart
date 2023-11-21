import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
String userId = '';

Future<List> getProducts() async {
  List products = [];
  CollectionReference referenceProducts = db.collection('products');

  QuerySnapshot queryProducts = await referenceProducts.get();

  queryProducts.docs.forEach((product) {
    Map<String, dynamic> productData = product.data() as Map<String, dynamic>;
    String productId = product.id;
    productData['id'] = productId;

    products.add(productData);
  });

  return products;
}

Future<List> getUserCart() async {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  DocumentSnapshot<Object?> userInfo = await userCollection.doc(userId).get();

  Map<String, dynamic> data = userInfo.data() as Map<String, dynamic>;
  Map cart = data['cart'];

  CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');
  DocumentSnapshot<Object?> product;
  List products = [];

  for (var productId in cart.keys) {
    product = await productsCollection.doc(productId).get();
    Map<String, dynamic> productData = product.data() as Map<String, dynamic>;
    productData['id'] = productId;

    products.add(productData);
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

Future<void> addToCart(String id) async {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  DocumentSnapshot<Object?> userInfo = await userCollection.doc(userId).get();

  Map<String, dynamic> data = userInfo.data() as Map<String, dynamic>;

  // Verifica si el usuario ya tiene un carrito
  if (data.containsKey('cart')) {
    Map<String, dynamic> cart = data['cart'];
    if (cart.containsKey(id)) {
      // Si el producto ya está en el carrito, actualiza la cantidad
      cart[id] = (cart[id] as int) + 1;
    } else {
      // Si el producto no está en el carrito, agrégalo
      cart[id] = 1;
    }
  } else {
    // Si el usuario no tiene un carrito, crea uno nuevo
    data['cart'] = {id: 1};
  }

  // Actualiza el carrito en la base de datos
  await userCollection
      .doc(userId)
      .set({'cart': data['cart']}, SetOptions(merge: true));
}

Future<void> deleteFromCart(String id) async {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  DocumentSnapshot<Object?> userInfo = await userCollection.doc(userId).get();

  Map<String, dynamic> data = userInfo.data() as Map<String, dynamic>;

  // Verifica si el usuario ya tiene un carrito
  if (data.containsKey('cart')) {
    Map<String, dynamic> cart = data['cart'];
    if (cart.containsKey(id) && cart[id] as int > 1) {
      // Si el producto ya está en el carrito, actualiza la cantidad
      cart[id] = (cart[id] as int) - 1;
    } else {
      // Si el producto no está en el carrito, agrégalo
      cart[id] = 1;
    }
  } else {
    // Si el usuario no tiene un carrito, crea uno nuevo
    data['cart'] = {id: 1};
  }

  // Actualiza el carrito en la base de datos
  await userCollection
      .doc(userId)
      .set({'cart': data['cart']}, SetOptions(merge: true));
}

Future<List> getUserCartQuantity() async {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  DocumentSnapshot<Object?> userInfo = await userCollection.doc(userId).get();
  Map<String, dynamic> data = userInfo.data() as Map<String, dynamic>;
  Map cart = data['cart'];
  List productsQuantity = [];

  for (var productQuan in cart.values) {
    productsQuantity.add(productQuan);
  }

  return productsQuantity;
}

Future<num> getUserCartTotal() async {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  DocumentSnapshot<Object?> userInfo = await userCollection.doc(userId).get();

  Map<String, dynamic> data = userInfo.data() as Map<String, dynamic>;
  Map cart = data['cart'];

  CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');
  DocumentSnapshot<Object?> product;
  num productsTotal = 0;
  num price = 0;

  for (var productId in cart.keys) {
    product = await productsCollection.doc(productId).get();
    print(product['price']);
    price = (product['price'] as num) * (cart[productId] as num);
    productsTotal += price;
  }

  return productsTotal;
}

Future<String> getImageUrl(String url) async {
  Reference storageReference = FirebaseStorage.instance.ref().child(url);
  return await storageReference.getDownloadURL();
}

void createUser(User user, String username, String email, String address) {
  FirebaseFirestore.instance.collection('users').doc(user.uid).set({
    'name': username,
    'e-mail': email,
    'address': address,
    'cart': {},
    'order': []
  });
}

void currentUser(String id) {
  userId = id;
}
