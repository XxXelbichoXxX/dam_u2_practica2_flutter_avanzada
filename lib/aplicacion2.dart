import 'package:dam_u2_practica2_flutter_avanzada/agenda.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'registra.dart';
import 'globals.dart' as globales;

class aplicacion2 extends StatefulWidget {
  const aplicacion2({Key? key}) : super(key: key);

  @override
  State<aplicacion2> createState() => _aplicacion2State();
}

class _aplicacion2State extends State<aplicacion2>{
  int _indice = 0;
  String _msj = "";


  void _cambiarIndice(int indice){
    setState(() {
      _indice = indice;
    });
  }


  final List<Widget> _paginas = [
    login(),
    registra(),
    agenda()
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Aplicacion 2"),centerTitle: true,backgroundColor: Colors.amber,actions: <Widget>[
        IconButton(onPressed: (){
          if(globales.estado == false){
            _msj = "No hay un inicio de sesión activo.";
          }else{
            _msj = "Gracias por agendar, vuelve pronto! :)";
          }
          showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  content: Text(_msj),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.of(context).pop();
                      FocusScopeNode current = FocusScope.of(context);
                      current.unfocus();
                      globales.estado = false;
                    }, child: Text("Salir"))
                  ],
                );
              }
          );
        }, icon: Icon(Icons.exit_to_app)),
      ],),
      body: _paginas[_indice],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.login),label: "Login"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Registra contacto"),
          BottomNavigationBarItem(icon: Icon(Icons.book),label: "Agenda"),
        ],
        currentIndex: _indice,
        backgroundColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber,
        onTap: _cambiarIndice,

      ),
    );
  }
}
int estado = 0;