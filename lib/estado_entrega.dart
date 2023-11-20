import 'package:flutter/material.dart';

class EstadoEntrega extends StatelessWidget {
  const EstadoEntrega({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                child: Card(
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
                              'GUADALAJARA, MÉXICO. FRANCISCO I MADERO # 39 A. C.P. 47254',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
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
                                        fontSize: 20, color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: 'Diciembre 2, 2023',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors
                                            .green, // Color verde para la fecha
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
