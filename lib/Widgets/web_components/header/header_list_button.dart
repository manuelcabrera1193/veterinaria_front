import 'package:accesorios_para_mascotas/models/body_enum.dart';
import 'package:accesorios_para_mascotas/models/page.dart';
import 'package:accesorios_para_mascotas/values/responsive_app.dart';
import 'package:flutter/material.dart';

class HeaderListButton extends StatefulWidget {
  final List<PageModel> views;
  final String title;
  final int index;
  final bool lineIsVisible;
  final Function(BodyEnum) redirect;

  const HeaderListButton(
      {Key? key,
      required this.views,
      required this.title,
      required this.index,
      required this.redirect,
      this.lineIsVisible = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _HeaderListButtonState();
}

class _HeaderListButtonState extends State<HeaderListButton> {
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
    return MyPopupMenuButton(
      hover: (value) {
        setState(() {
          value
              ? _isHovering[widget.index] = true
              : _isHovering[widget.index] = false;
        });
      },
      widget: InkWell(
        onHover: (value) {
          setState(() {
            value
                ? _isHovering[widget.index] = true
                : _isHovering[widget.index] = false;
          });
        },
        child: PopupMenuButton<PageModel>(
          tooltip: "",
          enabled: true,
          itemBuilder: (BuildContext context) => widget.views
              .map(
                (e) => PopupMenuItem<PageModel>(
                  value: e,
                  child: Text(e.name ?? ""),
                ),
              )
              .toList(),
          onSelected: (value) {
            if (value.bodyEnum == null) {
              return;
            }
            widget.redirect(value.bodyEnum!);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color:
                      _isHovering[widget.index] ? Colors.white : Colors.white70,
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
        ),
      ),
    );
  }
}

class MyPopupMenuButton extends StatefulWidget {
  final Widget widget;
  final Function(bool) hover;

  const MyPopupMenuButton({
    Key? key,
    required this.widget,
    required this.hover,
  }) : super(key: key);

  @override
  State<MyPopupMenuButton> createState() => _MyPopupMenuButtonState();
}

class _MyPopupMenuButtonState extends State<MyPopupMenuButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        isHovered = true;
        widget.hover(true);
      }),
      onExit: (_) => setState(() {
        isHovered = false;
        widget.hover(false);
      }),
      child: widget.widget,
    );
  }
}
