import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:madamecosmetics/models/Category.dart';

class AddCategoryScreen extends StatefulWidget {
  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}


class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  Category category = Category(id: 0, nameCategory: '');

  Future<void> addCategory() async {
    var url = Uri.parse("http://192.168.1.10/mysql/CategoryInsert.php");
    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
       
        body: categoryToJson(category),
      );

      if (response.body.startsWith('<')) {

        print('Respuesta no válida del servidor: ${response.body}');
        return;
      }

      var data = json.decode(response.body);
      if (data['error'] != null) {
        print('Error del servidor: ${data['error']}');
      } else {
        showSuccessMessage("Categoría agregada exitosamente");
        Navigator.pop(context);
        _formKey.currentState?.reset();
        category = Category.empty(); 
      }
    } catch (e) {

      print('Error al enviar la categoría: $e');
    }
  }

  void showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Categoría'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nombre de la categoría',
                  labelStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white70,
                ),
                onSaved: (value) {
                  setState(() {
                    category.nameCategory = value ?? '';
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre de la categoría es obligatorio.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    addCategory();
                  }
                },
                child: Text('Guardar Categoría'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}