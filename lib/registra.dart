import 'package:dam_u2_practica2_flutter_avanzada/sql_helper.dart';
import 'package:flutter/material.dart';
import 'aplicacion2.dart' as app2;
import 'globals.dart' as globales;

class registra extends StatefulWidget {
  const registra({Key? key}) : super(key: key);

  @override
  State<registra> createState() => _registraState();
}

class _registraState extends State<registra> {
  int st = 0;
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _numero = TextEditingController();

  Future<void> _addContact() async {
    await SQLHelper.createContact(_nombre.text, _numero.text);

  }
  void _clean(){
    _nombre.clear();
    _numero.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              globales.estado ? Text("REGISTRA A TUS AMIGOS O CONOCIDOS EN TU AGENDA PERSONAL", textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),) : Padding(padding: EdgeInsets.all(100), child: Text("INGRESA SESION PARA REGISTRAR TUS CONTACTOS", textAlign: TextAlign.center,style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),),
              Padding(padding: EdgeInsets.all(30), child:
              Visibility(visible: globales.estado ? true : false ,child: TextField(
                controller: _nombre,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Escribe su nombre',
                    labelText: "Nombre: ",
                    iconColor: Colors.amber,
                  )
              ),
              )),
              Padding(padding: EdgeInsets.all(30), child:
              Visibility(visible: globales.estado ? true : false ,child: TextField(
                  controller: _numero,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    hintText: 'Escribe su numero de celular ',
                    labelText: "Celular: ",
                    iconColor: Colors.amber,
                  )
              ),
              )),
              SizedBox(height: 40.0),
             Visibility(visible: globales.estado ? true : false ,
            child: OutlinedButton(onPressed: () async {
              await _addContact();
              _clean();
              showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      content: Text("Contacto guardado con exito"),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.of(context).pop();
                          FocusScopeNode current = FocusScope.of(context);
                          current.unfocus();
                        }, child: Text("Aceptar"))
                      ],
                    );
                  }
              );

                }, style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    fixedSize: const Size(300,50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    )
        ),
                    child: Text("Guardar contacto")))
            ],
          ),
        ),
      ),
    );
  }
}


