import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_12/darts/fetch_json.dart';
import 'package:flutter_application_12/screens/profile_shcreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_12/const.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  String info;
  HomePage({Key? key, required this.info}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color backgroundColor = Colors.white;
  List<dynamic>? data;

  Future<List<dynamic>> someData() async {
    setState(() {
      backgroundColor = Colors.lightBlue;
    });

    List<dynamic>? fetchedData = await fetchData();

    setState(() {
      data = fetchedData;
    });

    return data!;
  }

  Future<void> showSnack(BuildContext context) async {
    final message = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Profile_schreen(
                data: 'This message is from firest screen...111111 !',
              )),
    );

    // if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('.................. $message')));
  }

  _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', 'JohnDoe');
    print('Data saved');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<dynamic>>(
          future: someData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong !'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: Text('Please wait... '),
                  )
                ],
              ));
            } else {
              return Center(
                child: ListView.builder(
                    itemCount: (snapshot.data!.length),
                    itemBuilder: (context, index) {
                      return template(
                        id: snapshot.data![index]['id'].toString(),
                        title: snapshot.data![index]['title'],
                        url: snapshot.data![index]['url'],
                      );
                    }),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.cloud_circle),
        onPressed: () {
          //  TODO some...
          showSnack(context);
        },
      ),
    );
  }
}

Widget template(
    {String id = "No id", String title = "No title", String url = "No url"}) {
  return Card(
    elevation: 12,
    child: Row(
      children: [
        Container(
          height: 100,
          width: 100,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(
            color: getRandomColor(),
            width: 2.0,
            style: BorderStyle.solid,
          )),
          child: GestureDetector(
            onTap: () {
              BuildContext(context) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('URL'),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed:
                          ScaffoldMessenger.of(context).hideCurrentSnackBar,
                    ),
                  ),
                );
              }
            },
            child: Image.network(url),
          ),
        ),
        Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(id),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ]),
        ),
      ],
    ),
  );
}

Color getRandomColor() {
  Random random = Random();
  return Color.fromARGB(random.nextInt(256), random.nextInt(256),
      random.nextInt(256), random.nextInt(256));
}

// return ListTile(
//   title: Text(data![index]['title']),
//   subtitle: Text(data![index]['url']),
//   leading: Image.network(data![index]['url']),
// );
