import 'package:flutter/material.dart';
import 'globals.dart' as globales;

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _user = TextEditingController();
  final _pass = TextEditingController();
  String clase = "";
  List users = ["benigno","victor"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            children: [
              Flexible(
                  child: Padding(padding: EdgeInsets.fromLTRB(50, 20, 50, 0), child: Image.asset('img/cred.png'))),
                SizedBox(height: 20.0),
                Padding(padding: EdgeInsets.all(30), child: TextField(
                  controller: _user,
                  decoration: InputDecoration(
                    icon: Icon(Icons.supervised_user_circle),
                    hintText: 'Escribe tu usuario',
                    labelText: "Usuario",
                    iconColor: Colors.amber,
                  ),
                )),
                SizedBox(height: 5.0),
                Padding(padding: EdgeInsets.fromLTRB(30, 0, 30, 0), child: TextField(
                  controller: _pass,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: 'Escribe tu password',
                    labelText: "Password",
                    iconColor: Colors.amber,
                  ),
                )),
                SizedBox(height: 40.0),
                OutlinedButton(onPressed: (){
                  validar(_user.text,_pass.text);
                }, style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  fixedSize: const Size(300,50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                  )
                ),
                child: Text("Iniciar Sesión"))
            ],
          ),
        ),
    );
  }

  void validar(text, text2) {
    if(text==""){
      clase = "Usuario vacio, favor de completar el campo";
    }else if(text2==""){
      clase = "Campo de contraseña vacio, favor de completar el campo";
    }else if(users.contains(text) &&text2=="123"){
      clase = "¡Bienvenido al sistema!: $text";
      globales.estado = true;
      clean();

    }else{
      clase = "Claves incorrectas, no se permite acceso";
      clean();
    }
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          content: Text(clase),
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
  }

  void clean(){
    _user.clear();
    _pass.clear();
  }
}
