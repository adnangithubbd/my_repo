import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_12/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile_schreen extends StatefulWidget {
  String data;
  Profile_schreen({Key? key, required this.data}) : super(key: key);

  @override
  State<Profile_schreen> createState() => _Profile_schreenState();
}

class _Profile_schreenState extends State<Profile_schreen> {
  final TextEditingController cpassword = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    cpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.green[200],
        appBar: AppBar(title: const Text('Welcome to second schreen.. !')),
        body: Padding(
          padding: EdgeInsets.all(4),
          child: Center(
            child: Card(elevation: 12,
            child: Padding(padding: EdgeInsets.all(12),child: inputArea(),),),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showtoas(context, cpassword.text);
          },
          child: const Icon(Icons.cleaning_services),
        ),
      ),
    );
  }

Widget inputArea() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      TextField(
        decoration: InputDecoration(labelText: 'Username'),
      ),
      SizedBox(height: 12),
      TextField(
        obscureText: true,
        decoration: InputDecoration(labelText: 'Password'),
      ),
      SizedBox(height: 24),
      ElevatedButton(
        onPressed: () {
          // Handle login button press
        },
        child: Text('Login'),
      ),
    ],
  );
}


  Center input_area(BuildContext context) {
    return Center(
        child: SizedBox(
      width: MediaQuery.of(context).size.width / 1.20,
      child: TextField(
        obscureText: false,
        controller: cpassword,
        autofocus: true,
        decoration: const InputDecoration(
            border: OutlineInputBorder(), labelText: 'Password level'),
      ),
    ));
  }

  _showtoas(BuildContext context, String txt) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(txt),
      duration: Duration(seconds: 2),
    ));
  }

  _again(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1),
    ));
  }
}

// saveData() async {
//   final prefs = await SharedPreferences.getInstance();
//   prefs.setString('username', 'JohnDoe');
//   print('Data saved');
// }

// getData() async {
//   final prefs = await SharedPreferences.getInstance();
//   final username = prefs.getString('username') ?? 'No username';
//   print('Retrieved username: $username');
// }
