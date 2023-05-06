import 'dart:math';

import 'package:accesorios_para_mascotas/models/sale.dart';
import 'package:accesorios_para_mascotas/models/sale_detail.dart';
import 'package:accesorios_para_mascotas/screens/login/login_screen.dart';
import 'package:accesorios_para_mascotas/utils/botton_sheet.dart';
import 'package:accesorios_para_mascotas/utils/images.dart';
import 'package:accesorios_para_mascotas/utils/sizing_info.dart';
import 'package:accesorios_para_mascotas/values/responsive_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_sdk/flutter_paypal_sdk.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:paypal_sdk/catalog_products.dart';
// import 'package:paypal_sdk/core.dart';
// import 'package:paypal_sdk/orders.dart' as orderObj;
// import 'package:paypal_sdk/payments.dart';

class CardScreen extends StatefulWidget {
  final Sale sale;
  final Future<String> Function() saveSale;
  final Function() redirectHome;
  final Function() redirectLogin;
  final bool isLoggued;
  final String userId;

  const CardScreen({
    Key? key,
    required this.sale,
    required this.saveSale,
    required this.redirectHome,
    required this.redirectLogin,
    required this.isLoggued,
    required this.userId,
  }) : super(key: key);

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  late ResponsiveApp responsiveApp;

  @override
  Widget build(BuildContext context) {
    responsiveApp = ResponsiveApp(context);
    return isMobileAndTablet(context)
        ? Wrap(
            children: [
              ListTile(
                title: Text(
                  "Carro",
                  style: TextStyle(
                    letterSpacing: responsiveApp.letterSpacingCarouselWidth,
                    fontFamily: 'Electrolize',
                    fontSize: responsiveApp.headline6,
                  ),
                ),
              ),
              ...widget.sale.saleDetails
                  .map((e) => ItemCard(detail: e))
                  .toList(),
              if (widget.sale.saleDetails.isEmpty)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(8),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange[900]),
                  child: MaterialButton(
                    onPressed: widget.redirectHome,
                    child: const Center(
                      child: Text(
                        "Inicia las compras ...",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              Resume(
                  sale: widget.sale,
                  saveSale: widget.saveSale,
                  isLoggued: widget.isLoggued,
                  redirectLogin: widget.redirectLogin,
                  userId: widget.userId),
            ],
          )
        : Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(
                          "Carro",
                          style: TextStyle(
                            letterSpacing:
                                responsiveApp.letterSpacingCarouselWidth,
                            fontFamily: 'Electrolize',
                            fontSize: responsiveApp.headline3,
                          ),
                        ),
                      ),
                    ),
                    if (widget.sale.saleDetails.isEmpty)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.all(8),
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.orange[900]),
                        child: MaterialButton(
                          onPressed: widget.redirectHome,
                          child: const Center(
                            child: Text(
                              "Inicia las compras ...",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ...widget.sale.saleDetails
                        .map((e) => ItemCard(detail: e))
                        .toList(),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Resume(
                  sale: widget.sale,
                  redirectLogin: widget.redirectLogin,
                  saveSale: widget.saveSale,
                  isLoggued: widget.isLoggued,
                  userId: widget.userId,
                ),
              ),
            ],
          );
  }
}

class ItemCard extends StatelessWidget {
  final SaleDetail detail;
  const ItemCard({
    super.key,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(8),
      child: ListTile(
        leading: SizedBox(
          width: 48,
          height: 48,
          child: Image(image: addImage(detail.item.image)),
        ),
        title: Text(detail.item.name),
        trailing: Text("S/. ${detail.subtotal}"),
        subtitle: Text(
            "${detail.item.category.description} \t ${detail.item.additional.map((e) => e.name).toList().join(",")}"),
      ),
    );
  }
}

class Resume extends StatefulWidget {
  final Future<String> Function() saveSale;
  final Function() redirectLogin;
  final bool isLoggued;
  final String userId;

  const Resume({
    super.key,
    required this.sale,
    required this.redirectLogin,
    required this.saveSale,
    required this.isLoggued,
    required this.userId,
  });

  final Sale sale;

  @override
  State<Resume> createState() => _ResumeState();
}

class _ResumeState extends State<Resume> {
  late ResponsiveApp responsiveApp;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    responsiveApp = ResponsiveApp(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          "Resumen de la orden",
          style: TextStyle(
            fontFamily: 'Electrolize',
            fontSize: responsiveApp.headline6,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Productos:"),
                    Text("${widget.sale.saleDetails.length}"),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total:"),
                    Text("${widget.sale.total}"),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange[900]),
                  child: ElevatedButton(
                    onPressed: widget.sale.saleDetails.isEmpty
                        ? null
                        : () async {
                            if (!widget.isLoggued) {
                              widget.redirectLogin();
                            } else {
                              final idSale = await widget.saveSale();
                              await loadPayPal(widget.userId, idSale);
                            }
                          },
                    child: Center(
                      child: loading
                          ? const SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(),
                            )
                          : const Text(
                              "Pagar",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Future<void> loadPayPal(String userId, String idSale) async {
    loading = true;
    setState(() {});

    FlutterPaypalSDK sdk = FlutterPaypalSDK(
      clientId:
          'AccP_GyEEgvb25VbL4FN9S1_YMp4xqpUkSKoASy15vYixDuTe40IOTRSaMqLBP3tzKKar95OJDJvziQr',
      clientSecret:
          'EF-EAtNiMwYK7-S8uxdlvfuAKaiN7R349VebbcTThgl0vwK35072oTcbWR2jH4uaqEiXyeZYcDm2WgUB',
      mode: Mode.sandbox,
    );
    AccessToken accessToken = await sdk.getAccessToken();

    double mount = double.parse((widget.sale.total / 3.75).toStringAsFixed(2));

    String redirect = Uri.encodeFull(
        "https://accesorios-para-mascotas-96d2a.web.app/#/Home?transaction=$userId&codRef=$idSale");

    Map<String, dynamic> getTransaction() {
      Map<String, dynamic> transactions = {
        "intent": "sale",
        "payer": {
          "payment_method": "paypal",
        },
        "redirect_urls": {
          "return_url": redirect,
          "cancel_url": "https://accesorios-para-mascotas-96d2a.web.app/#/Home",
        },
        'transactions': [
          {
            "amount": {
              "currency": "USD",
              "total": mount.toString(),
            },
          }
        ],
      };

      return transactions;
    }

    Payment payment = await sdk.createPayment(
      getTransaction(),
      accessToken.token!,
    );

    if (payment.status) {
      loading = false;
      setState(() {});

      if (!await launchUrl(
        Uri.parse(payment.approvalUrl!),
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: "_self",
      )) {
        throw Exception(
            'Could not launch ${Uri.parse(payment.approvalUrl ?? "")}');
      }
    }
  }
}
