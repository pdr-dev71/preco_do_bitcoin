import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _price = '0';
  void recoverPrice() async {
    String urlApi = 'https://blockchain.info/ticker';
    http.Response response;
    response = await http.get(Uri.parse(urlApi));
    Map<String, dynamic> responseOb = jsonDecode(response.body);
    String brl = responseOb['BRL']['buy'].toString();
    setState(() {
      _price = brl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Preco do Bitcoin'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 28, right: 28),
            child: Image.asset('assets/images/bitcoin.png'),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24, top: 24),
            child: Text(
              'R\$ $_price',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 150,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onPressed: () {
                recoverPrice();
              },
              child: const Text(
                'Atualizar',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
