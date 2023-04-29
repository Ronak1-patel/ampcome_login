import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(_Myapp());
}

class _Myapp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyappState();
  }
}



class _MyappState extends State<_Myapp> {
  bool valuefirst = false;
  bool valuesecond = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("Daily News!..."),
            ),
            body: Column(
              children: [
                Text("lets create a Account"),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Enter a name*", labelText: "username"),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Mobile no*", labelText: "mobile number"),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  decoration:
                      InputDecoration(hintText: "Email", labelText: "Email*"),
                  keyboardType: TextInputType.emailAddress,
                ),
                SingleChildScrollView(child: Container(width: 282, height: 200, child: fetchapi())),
                OutlinedButton(onPressed: null, child: Text("submit"))
              ],
            )));
  }
}

class fetchapi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return fetchapistate();
  }
}

class fetchapistate extends State<fetchapi> {
  List data = [];
  String sid = '';
  var url = "https://jsonplaceholder.typicode.com/albums";

  Future fettchalbum() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body); //
      //Album.fromJson(jsonDecode(response.body));
      setState(() {
        data = jsonResponse;
      });
      return jsonResponse;
    } else {
      throw Exception('failed album');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fettchalbum();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DropdownButton(
      hint: Text("choose"),
      items: data.map((e) {
        return DropdownMenuItem(
          child: Text(e['title']),
          value: e['sid'].toString(),
        );
      }).toList(),
      onChanged: ((value) {
        setState(
          () {
            sid = value!;
          },
        );
      }),
    );
  }
}
