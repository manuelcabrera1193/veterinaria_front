import 'package:flutter/material.dart';

Future<T?> showModalBottomSheetCustom<T>({
  required BuildContext context,
  required Widget Function(BuildContext context) builder,
}) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
      ),
    ),
    backgroundColor: Theme.of(context).secondaryHeaderColor,
    elevation: 5,
    isScrollControlled: true,
    isDismissible: false,
    useSafeArea: true,
    context: context,
    builder: builder,
  );
}
