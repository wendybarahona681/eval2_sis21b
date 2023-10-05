import 'package:flutter/material.dart';
class AboutPage extends StatelessWidget {
// Datos de ambos
  final String names = 'Wendy Barahona \ Cruz Jimenez'; // Nombres de ambos
  final String emails =
      '.barahonawendy681@gmail.com \ andremolina211@gmail.com'; // Correos de ambos
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de nosotros'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//Images con ambas fotos
            Image.asset(
              'images/foto.jpeg', // Ruta de la imagen combinada
              width: 150.0,
              height: 150.0,
            ),
            SizedBox(height: 20.0),
            Text(
              names,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              emails,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}