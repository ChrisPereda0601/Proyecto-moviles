import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
String userId = '';

Future<Map<String, dynamic>> getProductById(String id) async {
  CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');
  DocumentSnapshot<Object?> productInfo = await productCollection.doc(id).get();

  Map<String, dynamic> product = productInfo.data() as Map<String, dynamic>;

  return product;
}

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

//Get user orders
Future<List<Map<String, dynamic>>> getUserOrder() async {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  DocumentSnapshot<Object?> userInfo = await userCollection.doc(userId).get();

  CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  Map<String, dynamic> data = userInfo.data() as Map<String, dynamic>;

  dynamic orderData = data['order'];
  List<Map<String, dynamic>> orderList = [];

  if (orderData is List<dynamic>) {
    for (var orderItem in orderData) {
      if (orderItem is Map<String, dynamic>) {
        List<Map<String, dynamic>> productList = [];

        for (var productId in orderItem.keys) {
          var productQuantity = orderItem[productId];

          DocumentSnapshot<Object?> product =
              await productsCollection.doc(productId).get();

          if (product.exists) {
            Map<String, dynamic> productData =
                (product.data() as Map<String, dynamic>)
                    .cast<String, dynamic>();
            productData['id'] = productId;
            productData['quantity'] = productQuantity;

            productList.add(productData);
          }
        }

        orderList.add({
          'orderDetails': orderItem,
          'products': productList,
        });
        print('${orderList}');
      }
    }
  }

  return orderList;
}

//Agregar nueva orden
Future<void> createOrder(List<Map<String, dynamic>> products) async {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  DocumentSnapshot<Object?> userInfo = await userCollection.doc(userId).get();

  Map<String, dynamic> orderData = {};

  Map<String, dynamic> userCart =
      (userInfo.data() as Map<String, dynamic>)['cart'];

  for (var product in products) {
    String productID = product['id'];
    int productQuantity =
        userCart.containsKey(productID) ? userCart[productID] : 0;

    DocumentSnapshot<Object?> productDoc = await FirebaseFirestore.instance
        .collection('products')
        .doc(productID)
        .get();

    if (productDoc.exists) {
      orderData['$productID'] = productQuantity;
    }
  }

  await userCollection.doc(userId).update({
    'order': FieldValue.arrayUnion([orderData]),
  });
}

Future<void> addToCart(String id) async {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  DocumentSnapshot<Object?> userInfo = await userCollection.doc(userId).get();

  Map<String, dynamic> data = userInfo.data() as Map<String, dynamic>;

  if (data.containsKey('cart')) {
    Map<String, dynamic> cart = data['cart'];
    if (cart.containsKey(id)) {
      cart[id] = (cart[id] as int) + 1;
    } else {
      cart[id] = 1;
    }
  } else {
    data['cart'] = {id: 1};
  }

  await userCollection
      .doc(userId)
      .set({'cart': data['cart']}, SetOptions(merge: true));
}

Future<void> deleteFromCart(String id) async {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  DocumentSnapshot<Object?> userInfo = await userCollection.doc(userId).get();

  Map<String, dynamic> data = userInfo.data() as Map<String, dynamic>;

  if (data.containsKey('cart')) {
    Map<String, dynamic> cart = data['cart'];
    if (cart.containsKey(id) && cart[id] as int > 1) {
      cart[id] = (cart[id] as int) - 1;
    } else {
      cart.remove(id);
    }
  } else {
    data['cart'] = {id: 1};
  }

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

//Eliminar carrito por completo
Future<void> clearUserCart() async {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  await userCollection.doc(userId).update({'cart': {}});
}

Future<String?> getAddress() async {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  DocumentSnapshot<Object?> userInfo = await userCollection.doc(userId).get();

  if (userInfo.exists && userInfo.data() != null) {
    Map<String, dynamic> data = userInfo.data() as Map<String, dynamic>;

    if (data.containsKey('address')) {
      return data['address'] as String?;
    }
  }

  return null;
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

Future<Map<String, dynamic>> getUserInfo() async {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  DocumentSnapshot<Object?> userInfo = await userCollection.doc(userId).get();

  if (userInfo.exists && userInfo.data() != null) {
    Map<String, dynamic> data = userInfo.data() as Map<String, dynamic>;
    print(data);

    return data;
  }

  return {};
}
