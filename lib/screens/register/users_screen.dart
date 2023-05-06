import 'package:accesorios_para_mascotas/models/profile.dart';
import 'package:accesorios_para_mascotas/screens/register/firestore_service.dart';
import 'package:accesorios_para_mascotas/screens/widgets/buttons_bottom.dart';
import 'package:accesorios_para_mascotas/screens/widgets/delete_widget.dart';
import 'package:accesorios_para_mascotas/screens/widgets/input.dart';
import 'package:accesorios_para_mascotas/screens/widgets/show_actions.dart';
import 'package:accesorios_para_mascotas/utils/sizing_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListUsersScreen extends StatefulWidget {
  const ListUsersScreen({Key? key}) : super(key: key);

  @override
  State<ListUsersScreen> createState() => _ListUsersScreenState();
}

class _ListUsersScreenState extends State<ListUsersScreen> {
  Future<List<Profile>> getUsers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').get();
    List<Profile> users = [];
    for (var doc in snapshot.docs) {
      Profile profile = Profile.fromMap(doc.data());
      users.add(profile);
    }
    return users;
  }

  String nameTable = "Usuario";
  String table = "users";

  List<Profile> _users = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() {
    loading = true;
    _users = [];
    getUsers().then((users) {
      if (mounted) {
        uid = "";
        _users = users;
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
                ],
              ),
            ),
          ),
          !loading
              ? Column(
                  children: _users.map((e) {
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
                        leading: ClipOval(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.network(
                              e.photo,
                              fit: BoxFit.fill,
                              errorBuilder: (_, a, b) => const Icon(
                                Icons.account_circle_sharp,
                              ),
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
                              e.email,
                              textAlign: TextAlign.center,
                            ),
                            if (uid == e.uid) const SizedBox(height: 24),
                            if (uid == e.uid)
                              ShowActionsWidget(
                                editWidget: EditUserWidget(
                                  value: e,
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

class EditUserWidget extends StatefulWidget {
  final Profile value;
  final void Function() refresh;

  const EditUserWidget({
    super.key,
    required this.value,
    required this.refresh,
  });

  @override
  State<EditUserWidget> createState() => _EditUserWidgetState();
}

class _EditUserWidgetState extends State<EditUserWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? name;
  String? email;
  String? phone;
  String? address;

  bool loading = false;

  String nameTable = "Usuario";
  String table = "users";

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
                labelText: "Nombre del $nameTable",
                enabled: true,
                initialValue: widget.value.name,
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
                labelText: "Email",
                enabled: false,
                initialValue: widget.value.email,
                validator: (value) {
                  return null;
                },
                onSaved: (value) {
                  email = value;
                },
              ),
              textFormFieldCustom(
                focusedBorderColor: Theme.of(context).primaryColor,
                labelText: "Celular",
                enabled: true,
                initialValue: widget.value.phoneNumber,
                validator: (value) {
                  if (value == null || value == "") {
                    return 'Ingrese un número de celular';
                  }
                  return null;
                },
                onSaved: (value) {
                  phone = value;
                },
              ),
              textFormFieldCustom(
                focusedBorderColor: Theme.of(context).primaryColor,
                labelText: "Dirección",
                enabled: true,
                initialValue: widget.value.address,
                validator: (value) {
                  return null;
                },
                onSaved: (value) {
                  address = value;
                },
              ),
              const SizedBox(height: 24),
              loading
                  ? const SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : ButtonsBottomWidget(event: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        _addUser(
                          Profile(
                            uid: widget.value.uid,
                            isLogged: widget.value.isLogged,
                            isAdmin: widget.value.isAdmin,
                            name: name ?? "",
                            email: email ?? "",
                            photo: widget.value.photo,
                            phoneNumber: phone ?? "",
                            address: address ?? "",
                          ),
                          () {
                            Navigator.pop(context);
                            widget.refresh();
                          },
                        );
                      }
                    }),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _addUser(Profile value, Function() close) async {
    try {
      setState(() {
        loading = true;
      });
      FirestoreService firestoreService = FirestoreService();
      firestoreService
          .updateDocument(table, value.uid, value.toMap())
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$nameTable actualizad@'),
          ),
        );
        close();
        setState(() {
          loading = false;
        });
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error editando el $nameTable'),
        ),
      );
    }
  }
}
