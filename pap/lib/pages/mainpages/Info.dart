// ignore_for_file: deprecated_member_use, avoid_print, avoid_function_literals_in_foreach_calls, unused_import

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pap/models/user.dart';
import 'package:pap/pages/homepage/homepage.dart';
import 'package:pap/pages/mainpages/scan.dart';

void pain() => runApp(const Info());

class Info extends StatelessWidget {
  const Info({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter InfoPage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const InfoPage(title: 'ListView das Tabelas'),
    );
  }
}

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  Future getInfo() async {
    int id = 1;
    User user = User();
    DatabaseReference ref = FirebaseDatabase(
            databaseURL:
                "https://alves-papflutter-default-rtdb.europe-west1.firebasedatabase.app")
        .ref("pap/id/ " + id.toString());

    final snapshot = await ref.get();
    if (snapshot.exists) {
      user.id = int.parse(snapshot.child("id").value.toString());
    } else {
      print('No data available.');
    }
    ref.onValue.listen((DatabaseEvent event) {
      print(event.snapshot.value);
    });

    return "a";
  }

  TextEditingController editingController = TextEditingController();

  final listaItems = List<String>.generate(100, (i) => "Item $i");
  var items = <String>[];
  void dee(String items) {
    listaItems.forEach((item) {});
  }

  @override
  void initState() {
    items.addAll(listaItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = <String>[];
    dummySearchList.addAll(listaItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = <String>[];
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(listaItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: getInfo(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        filterSearchResults(value);
                      },
                      controller: editingController,
                      decoration: const InputDecoration(
                          labelText: "Procurar",
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: ListTile(
                          title: Text(items[index]),
                          subtitle: const Text('Nome Pessoa'),
                          trailing: IconButton(
                              icon: const Icon(Icons.qr_code_2),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomePage()));
                              }),
                        ));
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          })),
    );
  }
}
