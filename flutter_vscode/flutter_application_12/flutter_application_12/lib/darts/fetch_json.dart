import 'package:flutter/material.dart';
import 'package:flutter_application_12/const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>?> fetchData() async {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/photos';

  var response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    for (var post in data) {
      // print('................................${post['title']} ');
      // print(post['url']);
    }
    return data;
  } else {
    print('Failed to fetch data. Error: ${response.reasonPhrase}');
    return null;
  }
}
