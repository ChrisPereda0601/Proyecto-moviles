import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:tienda_online/bloc/store_bloc.dart';
import 'package:tienda_online/services/firebase_services.dart';

class EstadoEntrega extends StatelessWidget {
  const EstadoEntrega({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime fechaActual = DateTime.now();

    int diasAleatorios = Random().nextInt(14) + 1;
    DateTime fechaEntrega = fechaActual.add(Duration(days: diasAleatorios));

    int _currentIndex = 0;
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
                height: 145,
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
                          padding: const EdgeInsets.all(4.0),
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
                                          text: 'Fecha de entrega: \n',
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
              BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                  _currentIndex = index;

                  _onTabTapped(index, context);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Inicio',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Buscar',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    label: 'Carrito',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: 'Pedidos',
                  ),
                ],
                selectedLabelStyle: TextStyle(color: Colors.black),
                unselectedLabelStyle: TextStyle(color: Colors.black54),
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTabTapped(int index, context) {
    switch (index) {
      case 0:
        BlocProvider.of<StoreBloc>(context).add(GetProductsEvent());
        break;
      case 1:
        BlocProvider.of<StoreBloc>(context).add(SearchEvent());
        break;
      case 2:
        BlocProvider.of<StoreBloc>(context).add(ViewCarEvent());
        break;
      case 3:
        BlocProvider.of<StoreBloc>(context).add(ViewOrdersEvent());
        break;
    }
  }

  String _formatFecha(DateTime fecha) {
    String nombreMes = DateFormat('MMMM').format(fecha);
    return "$nombreMes ${fecha.day}, ${fecha.year}";
  }
}
