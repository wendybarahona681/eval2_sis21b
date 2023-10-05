import 'package:flutter/material.dart';
import 'lista_registros.dart';

class  MyHomePage extends StatefulWidget{
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //aca va la lógica de la aplicación
  int _itemSelect =0;

  _onItemSelect(int pos){
    Navigator.pop(context); // close the drawer
    setState(() {
      _itemSelect = pos;

    });
  }

  _getItemDrawer(int position){
    switch (position){

      case 1:
        return ListaRegistros();
        break;
    }
  }


  //aca va el dieño de la UI

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pink,
              ),
              child: Text(
                'MEGATEC - ZACATECOLUCA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home,
                color: Colors.amber,),
              title: Text('HOME',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber
                ),),
              onTap: (){
                _onItemSelect(0);
              },
            ),
            Divider(color: Colors.red,),
            ListTile(
              leading: Icon(Icons.arrow_forward_ios),
              title: Text('About Page'),
              onTap: (){
                _onItemSelect(1);
              },
            ),
            Divider(color: Colors.red,),
            ListTile(
              leading: Icon(Icons.arrow_forward_ios),
              title: Text('Lista Registros'),
              onTap: (){
                _onItemSelect(1);
              },
            ),
          ],
        ),
      ),
      body: _getItemDrawer(_itemSelect),
    );
  }
}