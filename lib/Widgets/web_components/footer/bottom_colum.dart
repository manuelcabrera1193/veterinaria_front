import 'package:accesorios_para_mascotas/values/responsive_app.dart';
import 'package:flutter/material.dart';

class BottomColumn extends StatefulWidget {
  final String? heading;
  final String? s1;
  final String? s2;
  final String? s3;

  const BottomColumn({
    Key? key,
    required this.heading,
    required this.s1,
    required this.s2,
    required this.s3,
  }) : super(key: key);

  @override
  State<BottomColumn> createState() => _BottomColumnState();
}

class _BottomColumnState extends State<BottomColumn> {
  late ResponsiveApp responsiveApp;

  @override
  Widget build(BuildContext context) {
    responsiveApp = ResponsiveApp(context);
    return Padding(
      padding: responsiveApp.edgeInsetsApp?.onlyLargeBottomEdgeInsets ??
          const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.heading ?? "",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          createS(widget.s1, context),
          createS(widget.s2, context),
          createS(widget.s3, context)
        ],
      ),
    );
  }

  createS(String? s, context) {
    return Padding(
        padding: responsiveApp.edgeInsetsApp?.onlySmallTopEdgeInsets ??
            const EdgeInsets.all(0),
        child: Text(
          s ?? "",
          style: Theme.of(context).textTheme.bodyLarge,
        ));
  }
}
