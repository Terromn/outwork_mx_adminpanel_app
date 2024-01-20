import 'dart:io';

import 'package:flutter/material.dart';
import 'package:outwork_mx_admin_app/assets/app_color_palette.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../utils/get_media_query.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  Barcode? barcode;
  String qrText = '';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller.pauseCamera();
    }

    if (Platform.isIOS) {
      await controller.pauseCamera();
    }

    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
          child: Scaffold(
        
        backgroundColor: const Color(0xFF0A0813),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildQrView(context),
            Positioned(top: 15, child: buildResult()),
            Positioned(
              bottom: 30,
              child: ElevatedButton(
                onPressed: () {
                  if (barcode != null) {
                    Navigator.pushNamed(
                      context,
                      '/VerifyUserScreen',
                      arguments: {
                        'userUID': barcode!.code,
                      },
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('No se ha detectado ningun codigo...', style: TextStyle(color: TeAppColorPalette.black),),
                          backgroundColor: TeAppColorPalette.green),
                    );
                  }
                },
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      TeAppColorPalette.green), // Set the background color
                  textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                      fontFamily:
                          Theme.of(context).textTheme.titleMedium?.fontFamily,
                      fontSize:
                          Theme.of(context).textTheme.titleMedium?.fontSize,
                      fontWeight:
                          Theme.of(context).textTheme.titleMedium?.fontWeight,
                      color: TeAppColorPalette.black)), // Set the text style
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.all(12)), // Set the padding
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22))),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                  child: Text('Verificar Atleta'),
                ),
              ),
            )
          ],
        ),
      ));

  Widget buildResult() => Container(
        decoration: BoxDecoration(
          color: TeAppColorPalette.green,
          borderRadius: BorderRadius.circular(22),
        ),
        padding: const EdgeInsets.all(24),
        child: Text(
          barcode != null ? '${barcode!.code}' : 'Scanee un codigo',
          maxLines: 3,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: Theme.of(context).textTheme.titleMedium?.fontFamily,
              fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
              fontWeight: Theme.of(context).textTheme.titleMedium?.fontWeight,
              color: TeAppColorPalette.black),
        ),
      );

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderRadius: 10,
          borderLength: 20,
          borderWidth: 10,
          borderColor: TeAppColorPalette.green,
          cutOutSize: MediaQuery.of(context).size.width * .325,
        ),
      );

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((barcode) {
      setState(() {
        this.barcode = barcode;
      });
    });
  }
}
