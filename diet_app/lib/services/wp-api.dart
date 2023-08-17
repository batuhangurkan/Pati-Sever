import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> fetchWpPosts() async {
  final response = await http.get(
      Uri.parse('https://blog.petibom.com/wp-json/wp/v2/posts?_embed'),
      headers: {"Accept": "application/json"});
  var convertDatatoJson = jsonDecode(response.body);
  return convertDatatoJson;
}
