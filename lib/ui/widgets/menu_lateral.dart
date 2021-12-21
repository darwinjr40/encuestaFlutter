import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Container(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/fondo.jpg'), fit: BoxFit.cover)),
        ),
        ListTile(
            leading: Icon(
              Icons.list,
              color: Color.fromRGBO(59, 210, 127, 1.0),
            ),
            title: Text('Lista de encuestas'),
            onTap: () =>
                Navigator.pushReplacementNamed(context, 'lista_encuesta')),
        ListTile(
            leading: Icon(
              Icons.list_alt_outlined,
              color: Color.fromRGBO(59, 210, 127, 1.0),
            ),
            title: Text('Aplicaciones de encuestas'),
            onTap: () =>
                Navigator.pushReplacementNamed(context, 'aplicaciones'))
      ],
    );
  }
}
