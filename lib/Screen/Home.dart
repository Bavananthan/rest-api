import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List data = [];

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    setState(() {
      data = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REST API"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {

                fetchData();
              });
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              data[index]['title'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(data[index]['body']),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  data.removeAt(index);
                });
              },
              icon: Icon(Icons.delete),
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }
}
