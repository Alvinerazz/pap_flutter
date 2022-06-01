import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pap/models/user.dart';
import '/encrypt/encrypt.dart';

class ResultsPage extends StatelessWidget {
  int id = 1;

  ResultsPage({Key? key}) : super(key: key);

  Future getInfo() async {
    User user = User();
    //id = qrcoderesult;
    DatabaseReference ref = FirebaseDatabase(
            databaseURL:
                "https://alves-papflutter-default-rtdb.europe-west1.firebasedatabase.app")
        .ref("pap/id/" + id.toString());
    DatabaseReference refParque = FirebaseDatabase(
            databaseURL:
                "https://alves-papflutter-default-rtdb.europe-west1.firebasedatabase.app")
        .ref("pap/id/" + id.toString() + "/parque");

    final snapshot = await ref.get();
    if (snapshot.exists) {
      user.carro = snapshot.child("Carro").value.toString();
      user.contacto = int.parse(snapshot.child("Contacto").value.toString());
      user.dataValidade = snapshot.child("DataValidade").value.toString();
      user.matricula = snapshot.child("Matricula").value.toString();
      user.nome = snapshot.child("Nome").value.toString();
      user.role = snapshot.child("Role").value.toString();
      user.parque = Parque(
          b1SParadaI: false,
          b1SParadaS: false,
          b2SBar: false,
          b2SParada: false,
          b2SParque: false);
      print(snapshot.child("Parque/1S_ParadaI").value.toString());
      if (snapshot.child("Parque/1S_ParadaI").value.toString() == "true") {
        user.parque!.b1SParadaI = true;
      }
      if (snapshot.child("Parque/1S_ParadaS").value.toString() == "true") {
        user.parque!.b1SParadaS = true;
      }
      if (snapshot.child("Parque/2S_Bar").value.toString() == "true") {
        user.parque!.b2SBar = true;
      }
      if (snapshot.child("Parque/2S_Parada").value.toString() == "true") {
        user.parque!.b2SParada = true;
      }
      if (snapshot.child("Parque/2S_Parque").value.toString() == "true") {
        user.parque!.b2SParque = true;
      }
    } else {
      print('No data available.');
    }

    print(user.toString());
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getInfo(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data as User;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Informação ID - ' + id.toString(),
                  style: const TextStyle(color: Colors.black)),
              backgroundColor: Colors.blueAccent,
              automaticallyImplyLeading: true,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nome:',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Caveat",
                              fontWeight: FontWeight.w700),
                        ),
                        TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintStyle: const TextStyle(color: Colors.black),
                              hintText: user.nome),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Role:",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Caveat",
                              fontWeight: FontWeight.w700),
                        ),
                        TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintStyle: const TextStyle(color: Colors.black),
                              hintText: user.role),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Carro:",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Caveat",
                              fontWeight: FontWeight.w700),
                        ),
                        TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintStyle: const TextStyle(color: Colors.black),
                              hintText: user.carro),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Matricula:",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Caveat",
                              fontWeight: FontWeight.w700),
                        ),
                        TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintStyle: const TextStyle(color: Colors.black),
                              hintText: user.matricula),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "DataValidade:",
                          style: const TextStyle(
                              fontSize: 20,
                              fontFamily: "Caveat",
                              fontWeight: FontWeight.w700),
                        ),
                        TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintStyle: const TextStyle(color: Colors.black),
                              hintText: user.dataValidade),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Contacto:",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Caveat",
                              fontWeight: FontWeight.w700),
                        ),
                        TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintStyle: const TextStyle(color: Colors.black),
                              hintText: user.contacto.toString()),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Parque 1ª Secção:",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Caveat",
                              fontWeight: FontWeight.w700),
                        ),
                        Card(
                          elevation: 5,
                          child: ListTile(
                            title: const Text('Parada Inferior'),
                            subtitle: Text(
                                user.parque!.b1SParadaI.toString() == 'true'
                                    ? 'Sim'
                                    : 'Nao'),
                            trailing: const Icon(Icons.thumb_up),
                          ),
                        ),
                        Card(
                          elevation: 5,
                          child: ListTile(
                            title: const Text('Parada Superior'),
                            subtitle: Text(
                                user.parque!.b1SParadaS.toString() == 'true'
                                    ? 'Sim'
                                    : 'Nao'),
                            trailing: const Icon(Icons.thumb_down),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Parque 2ª Secção:",
                          style: const TextStyle(
                              fontSize: 20,
                              fontFamily: "Caveat",
                              fontWeight: FontWeight.w700),
                        ),
                        Card(
                          elevation: 5,
                          child: ListTile(
                            title: const Text('Parque Bar'),
                            subtitle: Text(
                                user.parque!.b2SBar.toString() == 'true'
                                    ? 'Sim'
                                    : 'Nao'),
                            trailing: const Icon(Icons.thumb_down),
                          ),
                        ),
                        Card(
                          elevation: 5,
                          child: ListTile(
                            title: const Text('Parque Parada'),
                            subtitle: Text(
                                user.parque!.b2SParada.toString() == 'true'
                                    ? 'Sim'
                                    : 'Nao'),
                            trailing: const Icon(Icons.thumb_up),
                          ),
                        ),
                        Card(
                          elevation: 5,
                          child: ListTile(
                            title: const Text('Parque Estacionamento'),
                            subtitle: Text(
                                user.parque!.b2SParque.toString() == 'true'
                                    ? 'Sim'
                                    : 'Nao'),
                            trailing: const Icon(Icons.thumb_up),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class Item {
  Item({
    this.expandedValue = "",
    this.headerValue = "",
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}
