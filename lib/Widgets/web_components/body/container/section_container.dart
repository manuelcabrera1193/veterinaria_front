import 'package:accesorios_para_mascotas/values/responsive_app.dart';
import 'package:flutter/material.dart';

class SectionContainer extends StatefulWidget {
  const SectionContainer({
    Key? key,
    required this.title,
    required this.subTitle,
    this.color,
  }) : super(key: key);

  final String title, subTitle;
  final Color? color;

  @override
  State<SectionContainer> createState() => _SectionContainerState();
}

class _SectionContainerState extends State<SectionContainer> {
  late ResponsiveApp responsiveApp;

  @override
  Widget build(BuildContext context) {
    responsiveApp = ResponsiveApp(context);
    return SizedBox(
      width: responsiveApp.width,
      child: Row(
        children: [
          Container(
            margin: responsiveApp.edgeInsetsApp?.onlyMediumRightEdgeInsets,
            padding: responsiveApp.edgeInsetsApp?.onlyLargeBottomEdgeInsets,
            width: responsiveApp.sectionWidth,
            height: responsiveApp.sectionHeight,
            color: Colors.black,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: widget.color,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.subTitle,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                widget.title,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
