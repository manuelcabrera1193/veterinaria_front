import 'package:accesorios_para_mascotas/utils/scroll.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class NosotrosWidget extends StatelessWidget {
  final AutoScrollController autoScrollController;
  const NosotrosWidget({
    super.key,
    required this.autoScrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          addScroll(
              const Card2Nosotros(
                title: "Acerca de Nosotros",
                description:
                    "Nuestro Equipo te garantiza una atencion A1. \nEn nuestra clínica encontrarás todo lo que tu mascota necesita en un solo lugar.\nConvivir con perros y gatos en el embarazo tiene beneficios para la salud ...",
              ),
              0,
              autoScrollController),
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Divider(
              height: 10,
            ),
          ),
          const Text(
            "Otros servicios que puede consultar",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Divider(
              height: 10,
            ),
          ),
          Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: 50,
            runSpacing: 50,
            //crossAxisCount: isMobileAndTablet(context) ? 4 : 2,
            children: const [
              CardNosotros(
                title: "Implante Microchip",
                description:
                    "Un microchip para perros siempre se mantendrá seguro en su lugar. Si sucede lo peor y tu perro se pierde, un microchip puede ayudar a garantizar ...",
              ),
              CardNosotros(
                title: "Ultrasonido",
                description:
                    "Consiste en echar un vistazo a los órganos que se encuentran en el abdomen y el tórax de su perro o su gato; estos órganos incluyen ...",
              ),
              CardNosotros(
                title: "Servicio de Transporte",
                description:
                    "Encontrar el servicio de transporte adecuado que pueda cuidar adecuadamente a su mascota, mantener el costo de la entrega a un precio bajo ...",
              ),
              CardNosotros(
                title: "Vacunas",
                description:
                    "Las vacunas más comunes son la trivalente, la tetravalente o bien la polivalente ...",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Card2Nosotros extends StatelessWidget {
  const Card2Nosotros({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardNosotros extends StatelessWidget {
  const CardNosotros({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
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
        width: 200,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 5,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                maxLines: 5,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
