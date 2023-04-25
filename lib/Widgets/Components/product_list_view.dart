import 'package:accesorios_para_mascotas/models/item_product.dart';
import 'package:accesorios_para_mascotas/utils/botton_sheet.dart';
import 'package:accesorios_para_mascotas/utils/images.dart';
import 'package:accesorios_para_mascotas/utils/sizing_info.dart';
import 'package:flutter/material.dart';

class ProductListView extends StatelessWidget {
  final List<ItemProduct> list;

  final Function(ItemProduct, int, bool) event;

  const ProductListView({
    Key? key,
    required this.list,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: isMobile(context) ? 2 : 4,
      shrinkWrap: true,
      children: list
          .map(
            (e) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Container(
                  height: 500,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: addImage(e.image),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white.withOpacity(0.6),
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${e.name}${e.name}${e.name}${e.name}${e.name}${e.name}${e.name}${e.name}${e.name}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  e.additional
                                      .map((e) => e.name)
                                      .toList()
                                      .join(","),
                                  style: const TextStyle(fontSize: 12.0),
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '\S/. ${e.price}',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    FloatingActionButton.small(
                                      elevation: 0,
                                      onPressed: () {
                                        showModalBottomSheetCustom(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AddCardModal(
                                                  event: (cantidad, redirect) {
                                                event(e, cantidad, redirect);
                                              });
                                            });
                                      },
                                      child: const Icon(Icons.add),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class AddCardModal extends StatefulWidget {
  final Function(int, bool) event;

  const AddCardModal({
    super.key,
    required this.event,
  });

  @override
  State<AddCardModal> createState() => _AddCardModalState();
}

class _AddCardModalState extends State<AddCardModal> {
  var cantidad = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: MediaQuery.of(context).size.width * 0.1,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Seleccione la cantidad:"),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton.small(
                onPressed: () {
                  if (cantidad > 1) cantidad--;
                  setState(() {});
                },
                child: const Icon(Icons.remove),
              ),
              const SizedBox(
                width: 50,
              ),
              Text("Cantidad: $cantidad"),
              const SizedBox(
                width: 50,
              ),
              FloatingActionButton.small(
                onPressed: () {
                  cantidad++;
                  setState(() {});
                },
                child: const Icon(Icons.add),
              )
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 50,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.red),
                  child: MaterialButton(
                    onPressed: () {
                      widget.event(cantidad, false);
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: const Text(
                      "Continuar comprando",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.red),
                  child: MaterialButton(
                    onPressed: () {
                      widget.event(cantidad, true);
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: const Text(
                      "Pagar",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
            ],
          )
        ],
      ),
    );
  }
}
