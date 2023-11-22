import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madamecosmetics/pages/HomePage.dart';
import 'package:madamecosmetics/pages/register_screen.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  //no se toca
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  String message = "";

  Future<void> login(BuildContext context) async {
    var url = Uri.parse("http://192.168.1.10/mysql/Login.php");
    try {
      final response = await http.post(url, body: {
        "username": user.text,
        "password": pass.text,
      });

      print("Respuesta del servidor: ${response.body}");

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data is List && data.isNotEmpty) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          message = "Usuario o contraseña incorrectos";
        }
      } else {
        message = "Error en la solicitud HTTP: ${response.statusCode}";
      }
    } catch (e) {
      message = "Ocurrió un error: $e";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.yellow[200]!,
                Colors.yellow[500]!,
              ]),
        ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Madame Cosmetic",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                const Text(
                  "Log In",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                ),
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    TextField(
                      controller: user,
                      decoration: InputDecoration(
                        hintText: "Nombre de Usuario",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 80, vertical: 17),
                        filled: true,
                        fillColor: Colors.white70,
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 35,
                      child: Icon(
                        Icons.person_2_outlined,
                        size: 30,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    TextField(
                      controller: pass,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Contraseña",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 80, vertical: 17),
                        filled: true,
                        fillColor: Colors.white70,
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 35,
                      child: Icon(
                        Icons.key_outlined,
                        size: 30,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: ElevatedButton(
                    onPressed: () {
                      //no se toca
                      login(context);
                      user.clear();
                      pass.clear();
                    },
                    child: Center(
                      child: Text(
                        "Iniciar Sesión",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      fixedSize: MaterialStateProperty.all<Size>(
                        Size.fromHeight(50),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        thickness: 1.5,
                        endIndent: 10,
                      ),
                    ),
                    Text(
                      "Nuestras Redes ",
                      style: TextStyle(fontSize: 19),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        thickness: 1.5,
                        endIndent: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        const instagramUrl =
                            'https://www.instagram.com/madame_natural_/';
                        if (await canLaunch(instagramUrl)) {
                          await launch(instagramUrl);
                        } else {
                          throw 'No se pudo abrir el enlace: $instagramUrl';
                        }
                      },
                      child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.black,
                          child: FaIcon(FontAwesomeIcons.instagram)),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.black,
                        child: FaIcon(FontAwesomeIcons.facebookF)),
                    SizedBox(
                      width: 50,
                    ),
                    CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.black,
                        child: FaIcon(FontAwesomeIcons.whatsapp)),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("No Tengo una Cuenta"),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Registrate Aquí",
                        style:
                            TextStyle(color: Colors.purpleAccent, fontSize: 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}
