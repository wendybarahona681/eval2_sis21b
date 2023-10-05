import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

/**Metodo para consultar toda la informacion de la coleccion tb_categoria */

Future<List> getStudiantes() async {
  List students = [];
  CollectionReference collectionReference = db.collection('tb_categoria');
  QuerySnapshot querySnapshot = await collectionReference.get();
  /* 
  for (var documento in querySnapshot.docs) { 
    students.add(documento.data()); 
    } 
    */
  querySnapshot.docs.forEach((documento) {
    students.add(documento.data());
  });
  //print('$students');
  return students;
}

Future<void> editAlumno(String id, String nombre, String apellidos) async {
  await db
      .collection('tb_categoria')
      .doc(id)
      .set({"first_name": nombre, "seconds_name": apellidos});
}
