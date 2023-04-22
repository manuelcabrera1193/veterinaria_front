import 'package:accesorios_para_mascotas/models/categories.dart';
import 'package:accesorios_para_mascotas/models/item_product.dart';
import 'package:accesorios_para_mascotas/screens/widgets/buttons_bottom.dart';
import 'package:accesorios_para_mascotas/screens/register/firestore_service.dart';
import 'package:accesorios_para_mascotas/screens/widgets/delete_widget.dart';
import 'package:accesorios_para_mascotas/screens/widgets/input.dart';
import 'package:accesorios_para_mascotas/screens/widgets/show_actions.dart';
import 'package:accesorios_para_mascotas/utils/botton_sheet.dart';
import 'package:accesorios_para_mascotas/utils/sizing_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String nameTable = "Producto";
  String table = "products";

  Future<List<ItemProduct>> getDocuments() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection(table).get();
    List<ItemProduct> objects = [];
    for (var doc in snapshot.docs) {
      ItemProduct object = ItemProduct.fromMap(doc.data());
      objects.add(object);
    }
    return objects;
  }

  List<ItemProduct> _objects = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() async {
    loading = true;
    _objects = [];
    final results = await getDocuments();
    if (mounted) {
      uid = "";
      _objects = results;
      loading = false;
      setState(() {});
    }
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
                children: [
                  Flexible(
                    child: Text(
                      "${nameTable}s",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      showModalBottomSheetCustom(
                          context: context,
                          builder: (BuildContext context) {
                            return EditWidget(
                              refresh: refresh,
                            );
                          });
                    },
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ),
          !loading
              ? Column(
                  children: _objects.map((e) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          if (uid == e.uid) {
                            uid = "";
                          } else {
                            uid = e.uid;
                          }
                          setState(() {});
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        tileColor: Theme.of(context).secondaryHeaderColor,
                        leading: const ClipOval(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(
                              Icons.category,
                            ),
                          ),
                        ),
                        title: Text(
                          e.name,
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Column(
                          children: [
                            Text(
                              "Precio: ${e.price}\nStock: ${e.stock}\nCategoria: ${e.category.name}",
                              textAlign: TextAlign.center,
                            ),
                            if (uid == e.uid) const SizedBox(height: 24),
                            if (uid == e.uid)
                              ShowActionsWidget(
                                editWidget: EditWidget(
                                  object: e,
                                  refresh: refresh,
                                ),
                                deleteWidget: DeleteWidget(
                                  object: e,
                                  refresh: refresh,
                                  table: table,
                                  nameTable: nameTable,
                                ),
                              ),
                            if (uid == e.uid) const SizedBox(height: 24),
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

class EditWidget extends StatefulWidget {
  final ItemProduct? object;
  final void Function() refresh;

  const EditWidget({
    super.key,
    this.object,
    required this.refresh,
  });

  @override
  State<EditWidget> createState() => _EditWidgetState();
}

class _EditWidgetState extends State<EditWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? name;
  double? price;
  Categories? categrySelected;
  int? stock;
  bool loading = false;

  List<Categories> _categories = [];

  String nameTable = "Producto";
  String table = "products";

  Future<List<Categories>> getCategories() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("categories").get();
    List<Categories> list = [];
    for (var doc in snapshot.docs) {
      Categories object = Categories.fromMap(doc.data());
      list.add(object);
    }
    return list;
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() async {
    _categories = [];
    final categories = await getCategories();
    if (mounted) {
      _categories = categories;
      if (categories
          .where((element) => element.uid == widget.object?.category.uid)
          .isNotEmpty) {
        categrySelected = categories.firstWhereOrNull(
            (element) => element.uid == widget.object?.category.uid);
      }
      loading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: MediaQuery.of(context).size.width * 0.2,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                nameTable,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              textFormFieldCustom(
                focusedBorderColor: Theme.of(context).primaryColor,
                labelText: "Nombre",
                enabled: true,
                initialValue: widget.object?.name ?? "",
                validator: (value) {
                  if (value == null || value == "") {
                    return 'Ingrese un nombre';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              textFormFieldCustom(
                focusedBorderColor: Theme.of(context).primaryColor,
                labelText: "Precio",
                enabled: true,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                initialValue: widget.object?.price.toString() ?? "",
                validator: (value) {
                  if (value == null || value == "") {
                    return 'Ingrese un Precio';
                  }
                  return null;
                },
                onSaved: (value) {
                  try {
                    price = double.tryParse(value ?? "0.0") ?? 0.0;
                  } catch (e) {
                    price = 0.0;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField<Categories>(
                validator: (value) {
                  if (value == null) {
                    return 'Seleccione una categoría';
                  }
                  return null;
                },
                onSaved: (value) {
                  try {
                    categrySelected = value;
                  } catch (e) {
                    categrySelected = null;
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  border: OutlineInputBorder(),
                ),
                hint: const Text("Selecciona una categoría"),
                value: categrySelected,
                isExpanded: true,
                icon: const Icon(Icons.category),
                items: _categories.map((e) {
                  return DropdownMenuItem<Categories>(
                    value: e,
                    child: Text(e.name),
                  );
                }).toList(),
                onChanged: (value) {
                  categrySelected = value;
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 20,
              ),
              textFormFieldCustom(
                focusedBorderColor: Theme.of(context).primaryColor,
                labelText: "Stock",
                enabled: true,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
                initialValue: widget.object?.stock.toString() ?? "",
                validator: (value) {
                  if (value == null || value == "") {
                    return 'Ingrese un Stock';
                  }
                  return null;
                },
                onSaved: (value) {
                  try {
                    stock = int.tryParse(value ?? "0") ?? 0;
                  } catch (e) {
                    stock = 0;
                  }
                },
              ),
              const SizedBox(height: 24),
              loading
                  ? const SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : ButtonsBottomWidget(
                      event: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          _add(
                            ItemProduct(
                              uid: widget.object?.uid ?? "",
                              name: name ?? "",
                              category: categrySelected!,
                              price: price!,
                              stock: stock!,
                            ),
                            () {
                              Navigator.pop(context);
                              widget.refresh();
                            },
                            widget.object == null,
                            table,
                            nameTable,
                          );
                        }
                      },
                    ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _add(
    ItemProduct object,
    Function() close,
    bool isNew,
    String table,
    String nameTable,
  ) async {
    try {
      setState(() {
        loading = true;
      });
      FirestoreService firestoreService = FirestoreService();
      if (isNew) {
        final result = firestoreService.addDocument(table, object.toMap());
        final idDocument = (await result).id;
        final newObject = object.copy(uid: idDocument);
        await firestoreService.updateDocument(
          table,
          idDocument,
          newObject.toMap(),
        );
        await _showSnackBar("$nameTable se guardo correctamente.");
        close();
        setState(() {
          loading = false;
        });
      } else {
        await firestoreService.updateDocument(
            table, object.uid, object.toMap());
        await _showSnackBar('$nameTable se actualizo correctamente.');
        close();
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      await _showSnackBar('Error editando $nameTable');
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> _showSnackBar(String message) async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    });
  }
}
