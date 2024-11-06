import 'package:flutter/material.dart';

class PerfilEstudianteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Nombre del Estudiante'),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Datos del Estudiante'),
              Tab(text: 'Notas'),
              Tab(text: 'Cursos Llevados'),
              Tab(text: 'Registro Extracurricular'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildDatosEstudiante(),
            _buildNotas(),
            _buildCursosLlevados(),
            _buildRegistroExtracurricular(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDatosEstudiante() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person,
              size: 80,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Información del Estudiante',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 16),
                _buildInfoRow('Nombre', 'Juan'),
                _buildInfoRow('Apellido', 'Pérez'),
                _buildInfoRow('Fecha de Nacimiento', '15/05/2005'),
                _buildInfoRow('Grado y Sección', '5to Sec A'),
                _buildInfoRow('Tutor', 'Sr. García'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildNotas() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('Criterios')),
          DataColumn(label: Text('Unidad 1')),
          DataColumn(label: Text('Unidad 2')),
          DataColumn(label: Text('Unidad 3')),
          DataColumn(label: Text('Unidad 4')),
          DataColumn(label: Text('Promedio')),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text('Comprensión de Álgebra')),
            DataCell(Text('18')),
            DataCell(Text('17')),
            DataCell(Text('16')),
            DataCell(Text('19')),
            DataCell(Text('17.5')),
          ]),
          DataRow(cells: [
            DataCell(Text('Resolución de Problemas en Geometría')),
            DataCell(Text('15')),
            DataCell(Text('16')),
            DataCell(Text('14')),
            DataCell(Text('17')),
            DataCell(Text('15.5')),
          ]),
        ],
      ),
    );
  }

  Widget _buildCursosLlevados() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nombre de Curso: Matemática',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Docente: Sr. García'),
              SizedBox(height: 8),
              Text('Horarios:'),
              Text('- Martes: 11:20 a 1:00'),
              Text('- Jueves: 11:20 a 1:00'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegistroExtracurricular(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                // Lógica para agregar una nueva actividad extracurricular
                _mostrarDialogoAgregar(context);
              },
              child: Text('Agregar'),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text('Clases')),
                DataColumn(label: Text('Descripción')),
                DataColumn(label: Text('Elimina')),
                DataColumn(label: Text('Edita')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('Fútbol')),
                  DataCell(Text(
                      'Actividad deportiva en la que se enseña a jugar al fútbol')),
                  DataCell(Checkbox(value: true, onChanged: (value) {})),
                  DataCell(TextButton(onPressed: () {}, child: Text('Editar'))),
                ]),
                DataRow(cells: [
                  DataCell(Text('Natación')),
                  DataCell(Text(
                      'Entrenamiento y práctica de la natación enfocada en técnicas')),
                  DataCell(Checkbox(value: true, onChanged: (value) {})),
                  DataCell(TextButton(onPressed: () {}, child: Text('Editar'))),
                ]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _mostrarDialogoAgregar(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agregar Actividad Extracurricular'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration:
                    InputDecoration(labelText: 'Nombre de la actividad'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Descripción'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                // Lógica para guardar la nueva actividad
                Navigator.of(context)
                    .pop(); // Cierra el diálogo después de guardar
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}
