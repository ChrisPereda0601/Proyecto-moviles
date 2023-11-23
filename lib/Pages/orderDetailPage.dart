import 'package:flutter/material.dart';
import 'package:tienda_online/services/firebase_services.dart';

class OrderDetailPage extends StatelessWidget {
  final Map<String, dynamic> orderDetailsList;

  OrderDetailPage({required this.orderDetailsList});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> productList =
        orderDetailsList['products'] as List<Map<String, dynamic>>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Orden'),
        backgroundColor: Color.fromRGBO(46, 38, 161, 1),
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> product = productList[index];

          return Card(
            elevation: 4.0,
            margin: EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: FutureBuilder(
                      future: getImageUrl(product['image']),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              snapshot.data.toString(),
                              width: 80.0,
                              height: 80.0,
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${product['name']}',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Precio: \$${product['price']}'),
                        Text('Cantidad: ${product['quantity']}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
