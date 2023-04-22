import 'package:accesorios_para_mascotas/screens/register/firestore_service.dart';
import 'package:accesorios_para_mascotas/screens/widgets/buttons_bottom.dart';
import 'package:flutter/material.dart';

class DeleteWidget extends StatefulWidget {
  final dynamic object;
  final String nameTable;
  final String table;
  final void Function() refresh;

  const DeleteWidget({
    super.key,
    required this.object,
    required this.nameTable,
    required this.table,
    required this.refresh,
  });

  @override
  State<DeleteWidget> createState() => _DeleteWidgetState();
}

class _DeleteWidgetState extends State<DeleteWidget> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 24,
          ),
          Text(
            "Estas seguro de eliminar ${widget.nameTable} : ${widget.object.name}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            "Luego de eliminar no podra recuperar.",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
          ),
          const SizedBox(
            height: 24,
          ),
          loading
              ? const SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator.adaptive(),
                )
              : ButtonsBottomWidget(
                  event: () {
                    _delete(
                      widget.object,
                      () {
                        Navigator.pop(context);
                        widget.refresh();
                      },
                    );
                  },
                ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _delete(dynamic value, Function() close) async {
    try {
      setState(() {
        loading = true;
      });
      FirestoreService firestoreService = FirestoreService();
      firestoreService.deleteDocument(widget.table, value.uid).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${widget.nameTable} eliminad@'),
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
          content: Text('Error eliminando ${widget.nameTable}'),
        ),
      );
    }
  }
}
