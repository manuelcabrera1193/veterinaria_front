import 'package:accesorios_para_mascotas/utils/botton_sheet.dart';
import 'package:flutter/material.dart';

class ShowActionsWidget extends StatelessWidget {
  final Widget editWidget;
  final Widget deleteWidget;

  const ShowActionsWidget({
    Key? key,
    required this.editWidget,
    required this.deleteWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
          ),
          child: FloatingActionButton(
            heroTag: UniqueKey(),
            child: const Icon(Icons.edit),
            onPressed: () {
              showModalBottomSheetCustom(
                  context: context,
                  builder: (BuildContext context) {
                    return editWidget;
                  });
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
          ),
          child: FloatingActionButton(
            heroTag: UniqueKey(),
            child: const Icon(Icons.delete),
            onPressed: () {
              showModalBottomSheetCustom(
                  context: context,
                  builder: (BuildContext context) {
                    return deleteWidget;
                  });
            },
          ),
        ),
      ],
    );
  }
}
