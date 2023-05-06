import 'package:accesorios_para_mascotas/models/categories.dart';
import 'package:accesorios_para_mascotas/screens/register/firestore_service.dart';
import 'package:accesorios_para_mascotas/screens/widgets/buttons_bottom.dart';
import 'package:accesorios_para_mascotas/screens/widgets/delete_widget.dart';
import 'package:accesorios_para_mascotas/screens/widgets/input.dart';
import 'package:accesorios_para_mascotas/screens/widgets/show_actions.dart';
import 'package:accesorios_para_mascotas/utils/botton_sheet.dart';
import 'package:accesorios_para_mascotas/utils/sizing_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

const String nameTable = "Categoria";
const String table = "categories";

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  Future<List<Categories>> getDocuments() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection(table).get();
    List<Categories> objects = [];
    for (var doc in snapshot.docs) {
      Categories object = Categories.fromMap(doc.data());
      objects.add(object);
    }
    return objects;
  }

  List<Categories> _objects = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() {
    loading = true;
    _objects = [];
    getDocuments().then((objects) {
      if (mounted) {
        uid = "";
        _objects = objects;
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
                children: [
                  const Flexible(
                    child: Text(
                      "${nameTable}s",
                      style: TextStyle(
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
                    heroTag: UniqueKey(),
                    onPressed: () {
                      showModalBottomSheetCustom(
                          context: context,
                          builder: (BuildContext context) {
                            return EditWidget(refresh: refresh);
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
                              e.description,
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
  final Categories? object;
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
  String? description;

  bool loading = false;

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
              const Text(
                nameTable,
                textAlign: TextAlign.center,
                style: TextStyle(
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
              textFormFieldCustom(
                focusedBorderColor: Theme.of(context).primaryColor,
                labelText: "Descripción",
                enabled: true,
                initialValue: widget.object?.description ?? "",
                validator: (value) {
                  if (value == null || value == "") {
                    return 'Ingrese una descripción';
                  }
                  return null;
                },
                onSaved: (value) {
                  description = value;
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
                              Categories(
                                uid: widget.object?.uid ?? "",
                                name: name ?? "",
                                description: description ?? "",
                              ), () {
                            Navigator.pop(context);
                            widget.refresh();
                          }, widget.object == null);
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

  void _add(Categories object, Function() close, bool isNew) async {
    try {
      setState(() {
        loading = true;
      });
      FirestoreService firestoreService = FirestoreService();
      if (isNew) {
        final result = firestoreService.addDocument(table, object.toMap());
        final idDocument = (await result).id;
        print("nuevo id $idDocument");
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
