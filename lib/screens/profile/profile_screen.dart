import 'package:accesorios_para_mascotas/models/profile.dart';
import 'package:accesorios_para_mascotas/utils/scroll.dart';
import 'package:accesorios_para_mascotas/utils/sizing_info.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ProfileScreen extends StatelessWidget {
  final Profile? user;
  final Future<void> Function()? logout;
  final AutoScrollController autoScrollController;
  const ProfileScreen({
    Key? key,
    required this.autoScrollController,
    required this.user,
    required this.logout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return addScroll(
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobileAndTablet(context)
                ? MediaQuery.of(context).size.height * 0.02
                : MediaQuery.of(context).size.height * 0.15,
            vertical: isMobileAndTablet(context)
                ? MediaQuery.of(context).size.height * 0.02
                : MediaQuery.of(context).size.height * 0.05,
          ),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFf44336),
                      Color(0xFFff5722),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    user?.photo.isEmpty ?? false
                        ? CircleAvatar(
                            radius: 50,
                            child: Transform.scale(
                              scale: 1,
                              child: const Icon(
                                Icons.account_circle_sharp,
                                size: 100,
                              ),
                            ),
                          )
                        : ClipOval(
                            child: Image.network(
                                user?.photo ??
                                    "https://lh3.googleusercontent.com/a/AGNmyxZH7LMJ8l2AQqQs82zd9DHD3EYd5zJRantPo-60=s96-c",
                                fit: BoxFit.cover,
                                width: 100.0,
                                height: 100.0, errorBuilder: (_, a, b) {
                              return CircleAvatar(
                                radius: 50,
                                child: Transform.scale(
                                  scale: 1,
                                  child: const Icon(
                                    Icons.account_circle_sharp,
                                    size: 100,
                                  ),
                                ),
                              );
                            }),
                          ),
                    const SizedBox(height: 10),
                    Text(
                      user?.name ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      user?.email ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Celular'),
                      subtitle: Text('-'),
                      trailing: Icon(Icons.edit),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.red),
                      child: MaterialButton(
                        onPressed: logout,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(Icons.logout, color: Colors.white),
                              SizedBox(width: 16),
                              Text("Cerrar Sesión",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      0,
      autoScrollController,
    );
  }
}
