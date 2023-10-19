import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:piramal_channel_partner/api/api_controller_expo.dart';
import 'package:piramal_channel_partner/api/api_end_points.dart';
import 'package:piramal_channel_partner/ui/qrCodeScanner/qr_code_scanner_presenter.dart';
import 'package:piramal_channel_partner/ui/qrCodeScanner/qr_code_view.dart';

import '../../res/AppColors.dart';
import '../../res/Fonts.dart';
import '../../res/Screens.dart';
import '../../utils/Utility.dart';
import '../../widgets/pml_button.dart';
import 'ScannerErrorWidget.dart';

class QRCodeScannerScreen extends StatefulWidget {
  final String fromScreen;

  const QRCodeScannerScreen(this.fromScreen, {Key key}) : super(key: key);

  @override
  _QRCodeScannerScreenState createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> implements QRCodeView {
  MobileScannerController controller = MobileScannerController();
  Barcode barcode;
  BarcodeCapture capture;

  Future<void> onDetect(BarcodeCapture barcode) async {
    capture = barcode;
    // setState(() => this.barcode = barcode.barcodes.first);

    if (widget.fromScreen == Screens.kLoginScreen ) {
      Barcode resultBarcode = barcode.barcodes.first;
      Navigator.pop(context);
      Navigator.pushNamed(context, Screens.kSignupScreenGuest, arguments: resultBarcode.displayValue);
    } else {
      // await controller.stop();

      if (alert == null) showDetailDialog(context, "Update Pax Size");
    }
  }

  MobileScannerArguments arguments;

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.center(Offset.zero),
      width: 200,
      height: 200,
    );
    return Scaffold(
      // appBar: AppBar(titlele: const Text('With Scan window')),
      backgroundColor: Colors.black,
      body: Builder(
        builder: (context) {
          return Stack(
            fit: StackFit.expand,
            children: [
              MobileScanner(
                fit: BoxFit.contain,
                scanWindow: scanWindow,
                controller: controller,
                onScannerStarted: (arguments) {
                  setState(() {
                    this.arguments = arguments;
                  });
                },
                errorBuilder: (context, error, child) {
                  return ScannerErrorWidget(error: error);
                },
                onDetect: onDetect,
              ),
              if (barcode != null && barcode.corners != null && arguments != null)
                CustomPaint(
                  painter: BarcodeOverlay(
                    barcode: barcode,
                    arguments: arguments,
                    boxFit: BoxFit.contain,
                    capture: capture,
                  ),
                ),
              CustomPaint(
                painter: ScannerOverlay(scanWindow),
              ),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Container(
              //     alignment: Alignment.bottomCenter,
              //     height: 100,
              //     color: Colors.black.withOpacity(0.4),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         Center(
              //           child: SizedBox(
              //             width: MediaQuery.of(context).size.width - 120,
              //             height: 50,
              //             child: FittedBox(
              //               child: Text(
              //                 barcode?.displayValue ?? 'Scan something!',
              //                 overflow: TextOverflow.fade,
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .headlineMedium
              //                     .copyWith(color: Colors.white),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }

  AlertDialog alert;
  String paxSize;
  void showDetailDialog(BuildContext context, String message) {
    alert = AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.white,
      scrollable: true,
      content: Column(
        children: [
          verticalSpace(20.0),
          PmlButton(
            width: 30,
            height: 30,
            color: AppColors.colorPrimary,
            child: Icon(Icons.close, color: AppColors.white, size: 16.0),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            // margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            child: Text("$message", style: textStyle14px500w),
          ),

          Container(
            height: 38,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: AppColors.inputFieldBackgroundColor,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 75,
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text("Pax Size", style: textStyle14px500w),
                ),
                Expanded(
                  child: TextFormField(
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.left,
                    // controller: emailTextController,
                    maxLines: 1,
                    textCapitalization: TextCapitalization.none,
                    style: textStyleSubText12px500w,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter pax size",
                      hintStyle: textStyleSubText12px500w,
                      isDense: true,
                      suffixStyle: TextStyle(color: AppColors.textColor),
                    ),
                    onChanged: (String val) {
                       paxSize = val;
                      // resetOTP();
                      /*      widget.onTextChange(val);
                        resetErrorOnTyping();*/
                    },
                  ),
                ),
              ],
            ),
          ),

          verticalSpace(10.0),
          PmlButton(
            width: 150,
            height: 36,
            text: "Update",
            onTap: () async {
              FocusScope.of(context).unfocus();
              QrCodeScannerPresenter presenter = QrCodeScannerPresenter(this);
              Barcode resultBarcode = capture.barcodes.first;
              presenter.updatePaxSize(context, resultBarcode.displayValue, paxSize);
            },
          ),
          verticalSpace(10.0),

        ],
      ),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);

  }

  @override
  void onPaxSizeUpdated() {
    Utility.showSuccessToastB(context, "Pax Size Updated");
    Navigator.pop(context);//pop dialog box
    Navigator.pop(context );// pop scanner screen
  }
}

class ScannerOverlay extends CustomPainter {
  ScannerOverlay(this.scanWindow);

  final Rect scanWindow;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Rect.largest);
    final cutoutPath = Path()..addRect(scanWindow);

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class BarcodeOverlay extends CustomPainter {
  BarcodeOverlay({
    this.barcode,
    this.arguments,
    this.boxFit,
    this.capture,
  });

  final BarcodeCapture capture;
  final Barcode barcode;
  final MobileScannerArguments arguments;
  final BoxFit boxFit;

  @override
  void paint(Canvas canvas, Size size) {
    if (barcode.corners == null) return;
    final adjustedSize = applyBoxFit(boxFit, arguments.size, size);

    double verticalPadding = size.height - adjustedSize.destination.height;
    double horizontalPadding = size.width - adjustedSize.destination.width;
    if (verticalPadding > 0) {
      verticalPadding = verticalPadding / 2;
    } else {
      verticalPadding = 0;
    }

    if (horizontalPadding > 0) {
      horizontalPadding = horizontalPadding / 2;
    } else {
      horizontalPadding = 0;
    }

    final ratioWidth = (Platform.isIOS ? capture.width : arguments.size.width) / adjustedSize.destination.width;
    final ratioHeight = (Platform.isIOS ? capture.height : arguments.size.height) / adjustedSize.destination.height;

    final List<Offset> adjustedOffset = [];
    for (final offset in barcode.corners) {
      adjustedOffset.add(
        Offset(
          offset.dx / ratioWidth + horizontalPadding,
          offset.dy / ratioHeight + verticalPadding,
        ),
      );
    }
    final cutoutPath = Path()..addPolygon(adjustedOffset, true);

    final backgroundPaint = Paint()
      ..color = Colors.red.withOpacity(0.3)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    canvas.drawPath(cutoutPath, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
