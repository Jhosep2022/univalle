import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:madamecosmetics/widgets/TechSupportWidget.dart';

void main() {
  runApp(FormScreen());
}

class FormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('FORMULARIO'),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: YourFormWidget(),
      ),
    );
  }
}

class YourFormWidget extends StatefulWidget {
  @override
  _YourFormWidgetState createState() => _YourFormWidgetState();
}

class _YourFormWidgetState extends State<YourFormWidget> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController severidadController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController ubicacionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Funciones de validación
  String? validateTitulo(String? value) {
    if (value == null || value.isEmpty) {
      return 'El título del problema es obligatorio.';
    }
    return null;
  }

  String? validateSeveridad(String? value) {
    if (value == null || value.isEmpty) {
      return 'La severidad del asunto es obligatoria.';
    }
    return null;
  }

  String? validateUbicacion(String? value) {
    if (value == null || value.isEmpty) {
      return 'La ubicación del fallo es obligatoria.';
    }
    return null;
  }

  String? validateDescripcion(String? value) {
    if (value == null || value.isEmpty) {
      return 'La descripción del problema es obligatoria.';
    }
    return null;
  }

  Future<void> enviarDatosAlServidor() async {
    final url = Uri.parse('http://192.168.1.10/mysql/Report.php');
    try {
      final response = await http.post(
        url,
        body: {
          'Problem_title': tituloController.text,
          'Affair': severidadController.text,
          'Failed': ubicacionController.text,
          'Description': descripcionController.text,
        },
      );
      print('Respuesta del servidor: ${response.body}');
    } catch (e) {
      print('Error en la solicitud HTTP: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Colors.yellow[200]!,
              Colors.yellow[400]!,
            ],
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16.0),
              TextFormField(
                controller: tituloController,
                decoration: InputDecoration(
                  labelText: 'Título del Problema',
                  labelStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white70,
                ),
                validator: validateTitulo,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: severidadController,
                decoration: InputDecoration(
                  labelText: 'Severidad del asunto',
                  labelStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white70,
                ),
                validator: validateSeveridad,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: ubicacionController,
                decoration: InputDecoration(
                  labelText: '¿Dónde se encuentra el fallo?',
                  labelStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white70,
                ),
                validator: validateUbicacion,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: descripcionController,
                decoration: InputDecoration(
                  labelText: 'Descripción del Problema',
                  labelStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white70,
                ),
                validator: validateDescripcion,
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        await enviarDatosAlServidor();
                        tituloController.clear();
                        severidadController.clear();
                        descripcionController.clear();
                        ubicacionController.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('ENVIAR', style: TextStyle(fontSize: 16.0)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TechnicalSupport()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('CANCELAR', style: TextStyle(fontSize: 16.0)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    tituloController.dispose();
    severidadController.dispose();
    descripcionController.dispose();
    ubicacionController.dispose();
    super.dispose();
  }
}
