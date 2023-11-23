import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:tienda_online/services/firebase_services.dart';

class EstadoEntrega extends StatelessWidget {
  const EstadoEntrega({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime fechaActual = DateTime.now();

    int diasAleatorios = Random().nextInt(14) + 1;
    DateTime fechaEntrega = fechaActual.add(Duration(days: diasAleatorios));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: IconButton(
              //     onPressed: () {
              //       // BlocProvider.of<StoreBloc>(context).add(ShowOrderProduct());
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => Orders.Orders(context),
              //         ),
              //       );
              //     },
              //     icon: Icon(Icons.arrow_back_ios_new_rounded),
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/delivery.png",
                    width: 300,
                    height: 300,
                  ),
                ],
              ),
              Wrap(
                children: [
                  Text(
                    "ITEStore te agradece, tu orden ha sido creada",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ],
              ),
              Divider(),
              Wrap(
                children: [
                  Text(
                    "Mantente atento a tu correo electrónico para más información",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                child: FutureBuilder<String?>(
                  future: getAddress(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      String? address = snapshot.data;

                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Tu pedido ha sido enviado a:',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              Wrap(
                                children: [
                                  Text(
                                    '${address ?? 'Dirección no disponible'}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Entrega garantizada: ',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '${_formatFecha(fechaEntrega)}',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatFecha(DateTime fecha) {
    String nombreMes = DateFormat('MMMM').format(fecha);
    return "$nombreMes ${fecha.day}, ${fecha.year}";
  }
}
