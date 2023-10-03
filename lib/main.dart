import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crud Firebase',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 80, 194, 60)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'CATEGORIAS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController idController = TextEditingController();
  final ValueNotifier<bool> activoCheckbox = ValueNotifier<bool>(false);
  final ValueNotifier<bool> inactivoCheckbox = ValueNotifier<bool>(false);
  final TextEditingController nombreController = TextEditingController();

  void _guardarDatos() {
    var estado;
    if (activoCheckbox.value) {
      estado = 'Activo';
    } else if (inactivoCheckbox.value) {
      estado = 'Inactivo';
    }

    FirebaseFirestore.instance.collection('tb_categoria').add({
      'id': idController.text,
      'estado': estado,
      'nombre': nombreController.text,
    });

    // Resetear los controladores después de guardar
    idController.clear();
    activoCheckbox.value = false;
    inactivoCheckbox.value = false;
    nombreController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Icon(Icons.perm_identity),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: idController,
                      decoration: InputDecoration(labelText: 'ID'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: activoCheckbox,
                    builder: (context, value, child) {
                      return Checkbox(
                        value: value,
                        onChanged: (newValue) {
                          activoCheckbox.value = newValue!;
                          if (newValue) {
                            inactivoCheckbox.value = false;
                          }
                        },
                      );
                    },
                  ),
                  Text('Activo'),
                  ValueListenableBuilder<bool>(
                    valueListenable: inactivoCheckbox,
                    builder: (context, value, child) {
                      return Checkbox(
                        value: value,
                        onChanged: (newValue) {
                          inactivoCheckbox.value = newValue!;
                          if (newValue) {
                            activoCheckbox.value = false;
                          }
                        },
                      );
                    },
                  ),
                  Text('Inactivo'),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: nombreController,
                      decoration: InputDecoration(labelText: 'Nombre'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                constraints: BoxConstraints.expand(height: 60),
                child: ElevatedButton(
                  onPressed: _guardarDatos,
                  child: Text(
                    'Guardar',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ListaRegistros(),
            ],
          ),
        ),
      ),
    );
  }
}

class ListaRegistros extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('tb_categoria').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        var registros = snapshot.data!.docs;

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Estado')),
                DataColumn(label: Text('Nombre')),
              ],
              rows: registros.map((registro) {
                var data = registro.data() as Map<String, dynamic>;
                return DataRow(
                  cells: [
                    DataCell(Text(data['id'])),
                    DataCell(Text(data['estado'])),
                    DataCell(Text(data['nombre'])),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
