import 'package:dam_u2_practica2_flutter_avanzada/sql_helper.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globales;

class agenda extends StatefulWidget {
  const agenda({Key? key}) : super(key: key);

  @override
  State<agenda> createState() => _agendaState();
}

class _agendaState extends State<agenda> {
  List<Map<String, dynamic>> _contactos = [];
  bool _cargando = true;

  void _deleteContact(int id) async {
    await SQLHelper.deleteContact(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Se ha eliminado el contacto'),));
    _muestraContactos();
  }

  void _muestraContactos() async {
    final data = await SQLHelper.getContacts();
    setState(() {
      _contactos = data;
      _cargando = false;
    });
  }


  @override
  void initState(){
    super.initState();
    _muestraContactos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: ListView.builder(
      itemCount: _contactos.length,
      itemBuilder: (context, index) => Card(
        color: Colors.amber,
        margin: const EdgeInsets.all(15),
        child: Visibility(visible: globales.estado ? true : false , child: ListTile(
          title: Text(_contactos[index]['nombre']),
          subtitle: Text(_contactos[index]['numero']),
          trailing: SizedBox(
            width: 50,
            child: Row(
              children: [
                IconButton(onPressed: () => _deleteContact(_contactos[index]['id'])
                    , icon: const Icon(Icons.delete_forever))
              ],
            ),
          ),
        ),
        ),
      )
    ),
    );
  }
}
