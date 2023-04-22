import 'package:accesorios_para_mascotas/models/body_enum.dart';
import 'package:accesorios_para_mascotas/models/page.dart';
import 'package:accesorios_para_mascotas/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:accesorios_para_mascotas/values/responsive_app.dart';
import 'package:accesorios_para_mascotas/values/string_app.dart';

class ShopDrawer extends StatefulWidget {
  final Function(BodyEnum body) redirect;
  final Profile? user;
  const ShopDrawer({
    Key? key,
    required this.redirect,
    required this.user,
  }) : super(key: key);

  @override
  State<ShopDrawer> createState() => _ShopDrawerState();
}

class _ShopDrawerState extends State<ShopDrawer> {
  late ResponsiveApp responsiveApp;

  bool showSubMenuRegister = false;

  @override
  Widget build(BuildContext context) {
    responsiveApp = ResponsiveApp(context);
    return SizedBox(
      width: responsiveApp.drawerWidth,
      child: Drawer(
        backgroundColor: Theme.of(context).primaryColor,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height * 0.1,
                child: Text(
                  copyrightStr,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.1,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UserAccountsDrawerHeader(
                      accountName: Text(widget.user?.name ?? "",
                          style: Theme.of(context).textTheme.titleLarge),
                      accountEmail: Text(widget.user?.email ?? ""),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background),
                      currentAccountPicture: ClipOval(
                        child: Image.network(
                          errorBuilder: (_, a, b) {
                            return Transform.scale(
                              scale: 3,
                              child: const CircleAvatar(
                                radius: 100,
                                child: Icon(
                                  Icons.account_circle_sharp,
                                ),
                              ),
                            );
                          },
                          widget.user?.photo ??
                              "https://graph.facebook.com/10162532623478998/picture",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    getItem(
                      onTap: () {
                        widget.redirect(BodyEnum.home);
                      },
                      title: home,
                      icon: Icons.article_outlined,
                    ),
                    getItem(
                      onTap: () {
                        widget.redirect(BodyEnum.nosotros);
                      },
                      title: nosotros,
                      icon: Icons.location_on_outlined,
                    ),
                    getItem(
                      onTap: () {
                        widget.redirect(BodyEnum.carrito);
                      },
                      title: carrito,
                      icon: Icons.local_grocery_store_outlined,
                    ),
                    getItem(
                      onTap: () {
                        widget.redirect(BodyEnum.ventas);
                      },
                      title: ventas,
                      icon: Icons.add_shopping_cart_rounded,
                    ),
                    widget.user?.isAdmin ?? false
                        ? getItems(
                            onTap: () {
                              showSubMenuRegister = !showSubMenuRegister;
                              setState(() {});
                            },
                            showSubMenuRegister: showSubMenuRegister,
                            event: (value) {
                              widget.redirect(value);
                            },
                            title: registros,
                            icon: Icons.app_registration_rounded,
                            list: listRegisters)
                        : const SizedBox.shrink(),
                    getItem(
                      onTap: () {
                        if (widget.user?.isLogged ?? false) {
                          widget.redirect(BodyEnum.profile);
                        } else {
                          widget.redirect(BodyEnum.login);
                        }
                      },
                      title: (widget.user?.isLogged ?? false) ? profile : login,
                      icon: Icons.lock_outline,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getItem({String? title, IconData? icon, onTap}) {
    return ListTile(
      onTap: onTap,
      title: Text(title ?? "", style: Theme.of(context).textTheme.bodyMedium),
      leading: Icon(
        icon,
        color: Theme.of(context).iconTheme.color,
      ),
    );
  }

  getItems({
    String? title,
    IconData? icon,
    Function()? onTap,
    Function(BodyEnum)? event,
    List<PageModel>? list,
    bool? showSubMenuRegister,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          title:
              Text(title ?? "", style: Theme.of(context).textTheme.bodyMedium),
          leading: Icon(
            icon,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        if (showSubMenuRegister ?? false)
          Column(
            children: list == null
                ? []
                : list.map((e) {
                    return ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      onTap: () {
                        if (event == null) return;
                        if (e.bodyEnum == null) return;
                        event(e.bodyEnum!);
                      },
                      leading: const Text(""),
                      title: Text(e.name ?? "",
                          style: Theme.of(context).textTheme.bodyMedium),
                    );
                  }).toList(),
          )
      ],
    );
  }
}
