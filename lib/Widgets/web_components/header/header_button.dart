import 'package:accesorios_para_mascotas/values/responsive_app.dart';import 'package:flutter/material.dart';

class HeaderButton extends StatefulWidget {
  final String title;
  final int index;
  final bool lineIsVisible;
  final Function() redirect;

  const HeaderButton(
      {Key? key,
      required this.title,
      required this.index,
      required this.redirect,
      this.lineIsVisible = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _HeaderButtonState();
}

class _HeaderButtonState extends State<HeaderButton> {
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  late ResponsiveApp responsiveApp;

  @override
  Widget build(BuildContext context) {
    responsiveApp = ResponsiveApp(context);
    return InkWell(
      onHover: (value) {
        setState(() {
          value
              ? _isHovering[widget.index] = true
              : _isHovering[widget.index] = false;
        });
      },
      onTap: widget.redirect,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              color: _isHovering[widget.index] ? Colors.white : Colors.white70,
            ),
          ),
          const SizedBox(height: 5),
          Visibility(
            maintainAnimation: true,
            maintainState: true,
            maintainSize: true,
            visible: widget.lineIsVisible
                ? _isHovering[widget.index]
                : widget.lineIsVisible,
            child: Container(
              height: responsiveApp.lineHznButtonHeight,
              width: responsiveApp.lineHznButtonWidth,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
