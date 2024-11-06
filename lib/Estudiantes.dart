import 'package:flutter/material.dart';
import 'PerfilEstudiante.dart';
import 'TestVocacional.dart';

class StudentsListScreen extends StatefulWidget {
  @override
  _StudentsListScreenState createState() => _StudentsListScreenState();
}

class _StudentsListScreenState extends State<StudentsListScreen> {
  final List<Map<String, String>> students = [
    {
      'apellido': 'Pérez',
      'nombre': 'Juan',
      'grado': '5to Sec. "A"',
      'tutor': 'Sr. García',
    },
    {
      'apellido': 'García',
      'nombre': 'María',
      'grado': '6to Prim. "B"',
      'tutor': 'Sra. Martínez',
    },
    {
      'apellido': 'Sánchez',
      'nombre': 'Pedro',
      'grado': '3ro Sec. "C"',
      'tutor': 'Sr. Rodríguez',
    },
    {
      'apellido': 'Martínez',
      'nombre': 'Luisa',
      'grado': '4to Prim. "A"',
      'tutor': 'Sra. Gómez',
    },
    {
      'apellido': 'Díaz',
      'nombre': 'Carlos',
      'grado': '2do Sec. "B"',
      'tutor': 'Sr. Fernández',
    },
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredStudents = students
        .where((student) =>
            student['nombre']!
                .toLowerCase()
                .contains(searchQuery.toLowerCase()) ||
            student['apellido']!
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Estudiantes'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _mostrarDialogoAgregar(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Buscar estudiante',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: filteredStudents.length,
                itemBuilder: (context, index) {
                  final student = filteredStudents[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${student['apellido']} ${student['nombre']}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Grado: ${student['grado']}\nTutor: ${student['tutor']}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TestVocacionalScreen(),
                                    ),
                                  );
                                },
                                child: Text('Test Vocacional'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PerfilEstudianteScreen(),
                                    ),
                                  );
                                },
                                child: Text('Perfil'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoAgregar(BuildContext context) {
    final TextEditingController apellidoController = TextEditingController();
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController gradoController = TextEditingController();
    final TextEditingController tutorController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agregar Estudiante'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: apellidoController,
                decoration: InputDecoration(labelText: 'Apellido'),
              ),
              TextField(
                controller: nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: gradoController,
                decoration: InputDecoration(labelText: 'Grado'),
              ),
              TextField(
                controller: tutorController,
                decoration: InputDecoration(labelText: 'Tutor'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  students.add({
                    'apellido': apellidoController.text,
                    'nombre': nombreController.text,
                    'grado': gradoController.text,
                    'tutor': tutorController.text,
                  });
                });
                Navigator.of(context).pop();
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}
