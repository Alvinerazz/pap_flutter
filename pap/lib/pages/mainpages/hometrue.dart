import 'package:flutter/material.dart';

class Hometrue extends StatelessWidget {
  const Hometrue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(children: <Widget>[
      SizedBox(
        height: size.height * 0.3,
        child: Stack(
          children: <Widget>[
            Container(
              height: size.height,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 10, 0, 145),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CircleAvatar(
                      radius: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset("assets/images/logo_pupilos.png"),
                      )),
                  Title(
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        "Hello World",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Expanded(
          child: GridView.count(
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Camera Scan'),
              ],
            ),
          ),
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Informação'),
              ],
            ),
          ),
        ],
      ))
    ]);
  }
}
