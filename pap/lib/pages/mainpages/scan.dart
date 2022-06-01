// ignore: import_of_legacy_library_into_null_safe
// ignore_for_file: deprecated_member_use

import 'package:barcode_scan/barcode_scan.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pap/models/user.dart';
import '/encrypt/encrypt.dart';
import 'package:pap/pages/mainpages/Results.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool infoPage = false;

  Future getInfo() async {
    User user = User();

    DatabaseReference ref = FirebaseDatabase(
            databaseURL:
                "https://alves-papflutter-default-rtdb.europe-west1.firebasedatabase.app")
        .ref("pap/id/" + qrCodeResult);
    DatabaseReference refParque = FirebaseDatabase(
            databaseURL:
                "https://alves-papflutter-default-rtdb.europe-west1.firebasedatabase.app")
        .ref("pap/id/" + qrCodeResult + "/parque");

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

  AESEncryption encryption = AESEncryption();
  String qrCodeResult = "Not Yet Scanned";
  @override
  Widget build(BuildContext context) {
    return !infoPage
        ? Scaffold(
            appBar: AppBar(
              title: const Text("Scanner"),
              centerTitle: true,
            ),
            body: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    "QrCode Scanner",
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Abra para Scannear o código",
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  FlatButton(
                    padding: const EdgeInsets.all(15.0),
                    onPressed: () async {
                      String codeSanner =
                          await BarcodeScanner.scan(); //barcode scnner
                      setState(() {
                        qrCodeResult = encryption
                            .decryptMsg(encryption.getCode(codeSanner))
                            .toString();
                        infoPage = true;
                      });
                    },
                    child: const Text(
                      "Camera Scanner",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.blue, width: 3.0),
                        borderRadius: BorderRadius.circular(20.0)),
                  )
                ],
              ),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                centerTitle: true,
                title: Text('QRInfo'),
                backgroundColor: Colors.blue,
                leading: GestureDetector(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onTap: () {
                    setState(() {
                      infoPage = false;
                      qrCodeResult = "Not Yet Scanned";
                    });
                  },
                ),
              ),
              FutureBuilder(
                future: getInfo(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    User user = snapshot.data as User;

                    return RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: "Num de Identificação: " + qrCodeResult,
                        ),
                        TextSpan(
                          text: "\nMatrícula: " + user.matricula.toString(),
                        ),
                        TextSpan(
                          text: "\nNome: " + user.nome.toString(),
                        ),
                        TextSpan(
                          text: "\nCarro: " + user.carro.toString(),
                        ),
                        TextSpan(
                          text: "\nRole: " + user.role.toString(),
                        ),
                        TextSpan(
                          text: "\nContacto: " + user.contacto.toString(),
                        ),
                        TextSpan(
                          text: "\nData Validade: " +
                              user.dataValidade.toString(),
                        ),
                        TextSpan(
                            text: user.parque!.b1SParadaI.toString() == 'true'
                                ? '\nParque 1sec ParadaInf: Sim'
                                : '\nParque 1sec ParadaI: Nao'),
                        TextSpan(
                            text: user.parque!.b1SParadaS.toString() == 'true'
                                ? '\nParque 1sec ParadaSup: Sim'
                                : '\nParque 1sec ParadaSup: Nao'),
                        TextSpan(
                            text: user.parque!.b2SBar.toString() == 'true'
                                ? '\nParque 2sec Bar: Sim'
                                : '\nParque 2sec Bar: Nao'),
                        TextSpan(
                            text: user.parque!.b2SParada.toString() == 'true'
                                ? '\nParque 2sec Parada: Sim'
                                : '\nParque 2sec Parada: Nao'),
                        TextSpan(
                            text: user.parque!.b2SParque.toString() == 'true'
                                ? '\nParque 2sec Parque: Sim'
                                : '\nParque 2sec Parque: Nao'),
                      ], style: TextStyle(color: Colors.black, fontSize: 25)),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              )
            ],
          );
  }
}
