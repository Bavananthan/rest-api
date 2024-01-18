import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List data = [];
  Future<void> fetchdata() async {
    final res = await http.get(Uri.parse("https://retoolapi.dev/ExAtIv/data"));

    print(res.body.toString());

    setState(() {
      data = json.decode(res.body)['data'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    data += [
                      {
                        "id": data.length + 1,
                        "logo": "https://logo.clearbit.com/hexun.com",
                        "name": "Haley St. Quintin",
                        "email": "dbergeon45@diigo.com",
                        "phone": "(555) 487-1843",
                        "location":
                            "Washington, District of Columbia, United States"
                      }
                    ];
                  });
                },
                icon: Icon(Icons.add))
          ],
          title: Text("REST Api"),
        ),
        body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {


           return ListTile(
                leading: CircleAvatar(
                    backgroundImage: NetworkImage(data[index]['avatar']),
                    radius: 30),
                title: Text(data[index]['first_name'],
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                subtitle: Text(data[index]['email']),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      data.removeWhere(
                          (entry) => entry['id'] == data[index]['id']);
                    });
                  },
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                ),
              );
            }));
  }
}
