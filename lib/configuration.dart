import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color primaryGreen = Color(0xff416d6d);
Color lightBlueGrad = HexColor("#0bbafb");
Color darkBlueGrad = HexColor("#4285ec");
List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.grey[300], blurRadius: 30, offset: Offset(0, 10))
];


List<Map> categories = [
  {'name': 'Audi', 'iconPath': 'assets/images/marcas/audi-logo.png'},
  {'name': 'BMW', 'iconPath': 'assets/images/marcas/bmw-logo.png'},
  {'name': 'Ford', 'iconPath': 'assets/images/marcas/ford-logo.png'},
  {'name': 'Mercedes', 'iconPath': 'assets/images/marcas/mercedes-benz-logo.png'},
  {'name': 'Toyota', 'iconPath': 'assets/images/marcas/toyota-logo.png'},

];

List<Map> drawerItems=[
  {
    'icon': FontAwesomeIcons.home,
    'title' : 'Inicio'
  },
  {
    'icon': Icons.settings,
    'title' : 'Configuración'
  },
  {
    'icon': FontAwesomeIcons.plus,
    'title' : 'Crear Anuncio'
  },
  {
    'icon': Icons.mail,
    'title' : 'Mensajes'
  },
  {
    'icon': FontAwesomeIcons.userAlt,
    'title' : 'Perfil'
  },
];


class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}