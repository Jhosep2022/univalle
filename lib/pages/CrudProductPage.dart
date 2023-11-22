import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:madamecosmetics/services/notification_services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:madamecosmetics/pages/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications();
  runApp(AddItemScreen());
}

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final Map<String, dynamic> newItem = {
    'image': '',
    'title': '',
    'description': '',
    'catalog': '',
    'price': 0,
    'offerPrice': null,
    'stock': '',
  };

  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        newItem['image'] = pickedFile.path;
      });
    }
  }

  Future<void> addProduct() async {
    var url = Uri.parse("http://192.168.1.10/mysql/Productinsert.php");
    try {
      var appDocDir = await getApplicationDocumentsDirectory();
      var localImagePath = '${appDocDir.path}/local_images';

      if (!Directory(localImagePath).existsSync()) {
        Directory(localImagePath).createSync(recursive: true);
      }

      if (newItem['image'] != '') {
        var imageFile = File(newItem['image']);
        var newImagePath = '$localImagePath/${DateTime.now().millisecondsSinceEpoch}.jpg';
        imageFile.copySync(newImagePath);

        newItem['image'] = newImagePath;
      }

      var response = await http.post(url, body: {
        "name_product": newItem['title'],
        "description_product": newItem['description'],
        "Catalogue": newItem['catalog'],
        "price_base": newItem['price'].toString(),
        "price_ofert": newItem['offerPrice']?.toString() ?? '',
        "Stock": newItem['stock']?.toString() ?? '',
      });

      var data = json.decode(response.body);
      if (data == "Error") {
        // Handle error case
      } else {
        showSuccessMessage("Registro exitoso");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );

        _formKey.currentState?.reset();
        newItem['image'] = '';
        newItem['title'] = '';
        newItem['description'] = '';
        newItem['catalog'] = '';
        newItem['price'] = 0;
        newItem['offerPrice'] = null;
      }
    } catch (e) {
      // Handle exception
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              ElevatedButton(
                onPressed: getImage,
                child: Text('Seleccionar Imagen'),
              ),
              if (newItem['image'] != '') Image.file(File(newItem['image'])),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Titulo',  
                  labelStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white70,
                ),
                onSaved: (value) => newItem['title'] = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El título es obligatorio.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Descripcion',
                  labelStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white70,
                ),
                onSaved: (value) => newItem['description'] = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La descripción es obligatoria.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Catalogo',
                  labelStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white70,
                ),
                onSaved: (value) => newItem['catalog'] = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El catálogo es obligatorio.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Stock',
                  labelStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white70,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[-]')),
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  LengthLimitingTextInputFormatter(4),
                ],
                onSaved: (value) {
                  newItem['stock'] = int.tryParse(value!) ?? 0;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El Stock es obligatorio.';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Ingrese un número válido para el Stock.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Precio',
                  labelStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white70,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[-]')),
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  LengthLimitingTextInputFormatter(4),
                ],
                onSaved: (value) {
                  newItem['price'] = int.tryParse(value!) ?? 0;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El precio es obligatorio.';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Ingrese un número válido para el precio.';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Oferta (Opcional)',
                  labelStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white70,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[-]')),
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  LengthLimitingTextInputFormatter(4),
                ],
                onSaved: (value) {
                  if (value != null && value.isNotEmpty) {
                    newItem['offerPrice'] = int.tryParse(value);
                  } else {
                    newItem['offerPrice'] = null;
                  }
                },
                validator: (value) {
                  if (value != null && value.isNotEmpty && int.tryParse(value) == null) {
                    return 'Ingrese un número válido para la oferta.';
                  }
                  return null;
                },
              ),

              
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    showNotification();
                    addProduct();
                  }
                },
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpdateItemScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const UpdateItemScreen({Key? key, required this.item}) : super(key: key);

  @override
  _UpdateItemScreenState createState() => _UpdateItemScreenState();
}

class _UpdateItemScreenState extends State<UpdateItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  late Map<String, dynamic> updatedItem;

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        updatedItem['image'] = pickedFile.path;
      });
    }
  }

  Future<void> updateProduct() async {
    var url = Uri.parse("http://localhost/mysql/Productupdate.php");
    try {
      var appDocDir = await getApplicationDocumentsDirectory();
      var localImagePath = '${appDocDir.path}/local_images';

      if (!Directory(localImagePath).existsSync()) {
        Directory(localImagePath).createSync(recursive: true);
      }

      if (updatedItem['image'] != '') {
        var imageFile = File(updatedItem['image']);
        var newImagePath = '$localImagePath/${DateTime.now().millisecondsSinceEpoch}.jpg';
        imageFile.copySync(newImagePath);

        updatedItem['image'] = newImagePath;
      }

      var response = await http.post(url, body: {
        "Id": updatedItem['id'].toString(),
        "name_product": updatedItem['title'],
        "description_product": updatedItem['description'],
        "Catalogue": updatedItem['catalog'],
        "price_base": updatedItem['price'].toString(),
        "price_ofert": updatedItem['offerPrice']?.toString() ?? '',
      });

      var data = json.decode(response.body);
      if (data == "Error") {
        showErrorMessage("Error al actualizar el producto");
      } else {
        showSuccessMessage("Actualización exitosa");
        Navigator.pop(context, updatedItem);
      }
    } catch (e) {
      showErrorMessage("Ocurrió un error: $e");
    }
  }

  Future<void> deleteProduct() async {
    var url = Uri.parse("http://localhost/mysql/Productdelete.php");
    try {
      var response = await http.post(url, body: {
        "Id": updatedItem['id'].toString(),
      });

      var data = json.decode(response.body);
      if (data == "Error") {
        showErrorMessage("Error al eliminar el producto");
      } else {
        showSuccessMessage("Eliminación exitosa");
        Navigator.pop(context, updatedItem);
      }
    } catch (e) {
      showErrorMessage("Ocurrió un error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    updatedItem = Map.from(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Item'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                ElevatedButton(
                  onPressed: getImage,
                  child: Text('Pick Image from Gallery'),
                ),
                if (updatedItem['image'] != '') Image.file(File(updatedItem['image'])),
                TextFormField(
                  initialValue: updatedItem['title'],
                  decoration: InputDecoration(labelText: 'Title'),
                  onSaved: (value) => updatedItem['title'] = value!,
                ),
                TextFormField(
                  initialValue: updatedItem['description'],
                  decoration: InputDecoration(labelText: 'Description'),
                  onSaved: (value) => updatedItem['description'] = value!,
                ),
                TextFormField(
                  initialValue: updatedItem['catalog'],
                  decoration: InputDecoration(labelText: 'Catalog'),
                  onSaved: (value) => updatedItem['catalog'] = value!,
                ),
                TextFormField(
                  initialValue: updatedItem['price'].toString(),
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => updatedItem['price'] = int.parse(value!),
                ),
                TextFormField(
                  initialValue: updatedItem['offerPrice'] != null ? updatedItem['offerPrice'].toString() : '',
                  decoration: InputDecoration(labelText: 'Offer Price'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    if (value != null && value.isNotEmpty) {
                      updatedItem['offerPrice'] = int.parse(value);
                    } else {
                      updatedItem['offerPrice'] = null;
                    }
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      updateProduct();
                    }
                  },
                  child: Text('Update'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Add confirmation dialog before deleting
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Confirm Deletion"),
                          content: Text("Are you sure you want to delete this item?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                deleteProduct();
                              },
                              child: Text("Delete"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
