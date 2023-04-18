import 'package:flutter/material.dart';
import 'package:accesorios_para_mascotas/Values/ResponsiveApp.dart';

class BottomColumn extends StatelessWidget {
  final String? heading;
  final String? s1;
  final String? s2;
  final String? s3;

  BottomColumn({
        Key? key,
    required this.heading,
    required this.s1,
    required this.s2,
    required this.s3,
  }): super(key: key);

  late ResponsiveApp responsiveApp;
  @override
  Widget build(BuildContext context) {
    responsiveApp = ResponsiveApp(context);
    return Padding(
      padding: responsiveApp.edgeInsetsApp?.onlyLargeBottomEdgeInsets ?? const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading ?? "",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          createS(s1, context),
          createS(s2, context),
          createS(s3, context)
        ],
      ),
    );
  }

  createS(String? s, context) {
    return Padding(
        padding: responsiveApp.edgeInsetsApp?.onlySmallTopEdgeInsets ?? const EdgeInsets.all(0),
        child: Text(
          s ?? "",
          style: Theme.of(context).textTheme.bodyLarge,
        ));
  }
}
