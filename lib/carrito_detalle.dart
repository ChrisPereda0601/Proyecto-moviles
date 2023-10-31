import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

class CarritoDetalle extends StatefulWidget {
  const CarritoDetalle({super.key});

  @override
  State<CarritoDetalle> createState() => _CarritoDetalleState();
}

class _CarritoDetalleState extends State<CarritoDetalle> {
  double _total = 0;

  List<Producto> carrito = [
    Producto(
      nombre: 'Producto 1',
      precio: 20.0,
      cantidad: 2,
    ),
    Producto(
      nombre: 'Producto 2',
      precio: 30.0,
      cantidad: 1,
    ),
    Producto(
      nombre: 'Producto 3',
      precio: 50.0,
      cantidad: 3,
    ),
    Producto(
      nombre: 'Producto 4',
      precio: 50.0,
      cantidad: 2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GlamourStore'),
        backgroundColor: Color.fromRGBO(46, 38, 161, 1),
        actions: [
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: carrito.length,
              itemBuilder: (context, index) {
                final producto = carrito[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/bocina.jpg',
                          width: 80.0,
                          height: 80.0,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                producto.nombre,
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Text(
                                '\$${producto.precio}',
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                        // Eliminar
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {},
                        ),
                        // Cantidad
                        Text(
                          'Cantidad: ${producto.cantidad}',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        // Agregar
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 27, 144, 180),
                      borderRadius: BorderRadius.circular(
                          10.0) // Añadir esquinas redondeadas
                      ),
                  child: Center(
                    child: Text(
                      "Total: ${calculateTotal()}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                //Cuenta para paypal
                //Usuario: sb-1y6fe27160910@personal.example.com
                //password: mPe)C6Mk
                onPressed: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => PaypalCheckout(
                sandboxMode: true,
                clientId: "Ae5yu_1YTFRIUbx210ojdzwSFW2fZl8gPUyk9AvWMp-HoXqJpoamsmrUBFCR5F_mB1OifMdxOJ4uvmo6",
                secretKey: "EN0lddmvqyvk-R2irxHgX8CdpyylFY3hD9vB9CSNk7pOT30fT_EvrSShDB-Lfdq7C37Op7JerkpGH2kM",
                returnURL: "success.snippetcoder.com",
                cancelURL: "cancel.snippetcoder.com",
                transactions: const [
                  {
                    "amount": {
                      "total": '70',
                      "currency": "USD",
                      "details": {
                        "subtotal": '70',
                        "shipping": '0',
                        "shipping_discount": 0
                      }
                    },
                    "description": "The payment transaction description.",
                    // "payment_options": {
                    //   "allowed_payment_method":
                    //       "INSTANT_FUNDING_SOURCE"
                    // },
                    "item_list": {
                      "items": [
                        {
                          "name": "Apple",
                          "quantity": 4,
                          "price": '5',
                          "currency": "USD"
                        },
                        {
                          "name": "Pineapple",
                          "quantity": 5,
                          "price": '10',
                          "currency": "USD"
                        }
                      ],

                      // shipping address is not required though
                      //   "shipping_address": {
                      //     "recipient_name": "Raman Singh",
                      //     "line1": "Delhi",
                      //     "line2": "",
                      //     "city": "Delhi",
                      //     "country_code": "IN",
                      //     "postal_code": "11001",
                      //     "phone": "+00000000",
                      //     "state": "Texas"
                      //  },
                    }
                  }
                ],
                note: "Contact us for any questions on your order.",
                onSuccess: (Map params) async {
                  print("onSuccess: $params");
                },
                onError: (error) {
                  print("onError: $error");
                  Navigator.pop(context);
                },
                onCancel: () {
                  print('cancelled:');
                },
              ),
            ));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 36, 181, 225),
                  ),
                ),
                child: Text("Confirmar compra"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 36, 181, 225),
                  ),
                ),
                child: Text(
                  "Vaciar carrito",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double calculateTotal() {
    for (int i = 0; i < carrito.length; i++) {
      Producto product = carrito[i];
      _total += (product.precio * product.cantidad);
    }
    return _total;
  }
}

class Producto {
  final String nombre;
  final double precio;
  int cantidad;

  Producto({
    required this.nombre,
    required this.precio,
    required this.cantidad,
  });
}
