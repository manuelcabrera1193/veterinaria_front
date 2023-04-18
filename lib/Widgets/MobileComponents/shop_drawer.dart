import 'package:accesorios_para_mascotas/screens/home/body_enum.dart';
import 'package:flutter/material.dart';
import 'package:accesorios_para_mascotas/Values/ResponsiveApp.dart';
import 'package:accesorios_para_mascotas/Values/StringApp.dart';

class ShopDrawer extends StatefulWidget {
  final Function(BodyEnum body) redirect;
  const ShopDrawer({
    Key? key,
    required this.redirect,
  }) : super(key: key);

  @override
  State<ShopDrawer> createState() => _ShopDrawerState();
}

class _ShopDrawerState extends State<ShopDrawer> {
  late ResponsiveApp responsiveApp;

  @override
  Widget build(BuildContext context) {
    responsiveApp = ResponsiveApp(context);
    return SizedBox(
      width: responsiveApp.drawerWidth,
      child: Drawer(
        child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(nameStr,
                      style: Theme.of(context).textTheme.titleLarge),
                  accountEmail: Text(emailDefaultStr),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background),
                  currentAccountPicture: CircleAvatar(
                    //backgroundImage: AssetImage('assets/images/cody.jpg'),
                    child: Transform.scale(
                      scale: 3,
                      child: const Icon(
                        Icons.account_circle_rounded,
                        weight: 10,
                      ),
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
                    widget.redirect(BodyEnum.registros);
                  },
                  title: registros,
                  icon: Icons.app_registration_rounded,
                ),
                getItem(
                  onTap: () {
                    widget.redirect(BodyEnum.contacts);
                  },
                  title: contactos,
                  icon: Icons.contacts,
                ),
                getItem(
                  onTap: () {
                    widget.redirect(BodyEnum.login);
                  },
                  title: login,
                  icon: Icons.lock_outline,
                ),
                Expanded(
                    child: Padding(
                  padding: responsiveApp.edgeInsetsApp?.allMediumEdgeInsets ??
                      const EdgeInsets.all(0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      copyrightStr,
                      style: Theme.of(context).accentTextTheme.bodyMedium,
                    ),
                  ),
                ))
              ],
            )),
      ),
    );
  }

  getItem({String? title, IconData? icon, onTap}) {
    return ListTile(
      onTap: onTap,
      title: Text(title ?? "", style: Theme.of(context).textTheme.bodyText2),
      leading: Icon(
        icon,
        color: Theme.of(context).iconTheme.color,
      ),
    );
  }
}
