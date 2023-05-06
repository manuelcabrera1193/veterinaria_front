import 'package:accesorios_para_mascotas/models/sale.dart';
import 'package:accesorios_para_mascotas/utils/sizing_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  Future<List<Sale>> getSales() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('sales').get();
    List<Sale> sales = [];
    for (var doc in snapshot.docs) {
      Sale sale = Sale.fromMap(doc.data());
      sales.add(sale);
    }
    return sales;
  }

  List<Sale> _sales = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() {
    loading = true;
    _sales = [];
    getSales().then((sales) {
      if (mounted) {
        uid = "";
        _sales = sales;
        loading = false;

        setState(() {});
      }
    });
  }

  var uid = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal:
            isMobile(context) ? 20 : MediaQuery.of(context).size.width * 0.15,
      ),
      child: Column(
        children: [
          Card(
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Flexible(
                    child: Text(
                      "Ventas",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          !loading
              ? Column(
                  children: _sales.map((e) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          if (uid == e.uid) {
                            uid = "";
                          } else {
                            uid = e.uid ?? "";
                          }
                          setState(() {});
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        tileColor: Theme.of(context).secondaryHeaderColor,
                        leading: ClipOval(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child:
                                Icon(e.completed ? Icons.check : Icons.close),
                          ),
                        ),
                        title: Text(
                          "${e.usuario.name} - ${e.usuario.email}",
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Column(
                          children: [
                            Text(
                              e.saleDetails
                                  .map((e) =>
                                      "Producto: ${e.item.name} - Precio: ${e.item.price} - Cantidad: ${e.cantidad}")
                                  .toList()
                                  .join("\n"),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                )
              : const Padding(
                  padding: EdgeInsets.all(50.0),
                  child: SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(),
                  ),
                ),
        ],
      ),
    );
  }
}
