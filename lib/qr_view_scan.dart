import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tienda_online/bloc/store_bloc.dart';
import 'package:tienda_online/services/firebase_services.dart';

class QRViewScan extends StatefulWidget {
  const QRViewScan({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewScanState();
}

class _QRViewScanState extends State<QRViewScan> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: _buildQrView(context),
          ),
          BlocListener<StoreBloc, StoreState>(
            listener: (context, state) {
              if (state is QrProductState) {
                _showProductDialog(context, state.product);
              }
            },
            child: Container(),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        BlocProvider.of<StoreBloc>(context)
            .add(QrProductEvent(id_product: result.toString()));
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _showProductDialog(BuildContext context, Map<dynamic, dynamic> product) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            actions: [
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<StoreBloc>(context).add(GetProductsEvent());
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text("Cerrar"))
            ],
            title: Text("${product['name']}"),
            content: Container(
              height: 600,
              child: Column(
                children: [
                  FutureBuilder(
                    future: getImageUrl(product['image']),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        return Image.network(
                          snapshot.data.toString(),
                          width: MediaQuery.of(context).size.width / 1.7,
                          fit: BoxFit.fill,
                        );
                      }
                    },
                  ),
                  Text("${product['description']}")
                ],
              ),
            ),
          );
        });
  }
}
