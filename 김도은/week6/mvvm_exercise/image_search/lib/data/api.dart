// 최상위 함수로 사용하는 방법 => but.. 최상위 함수를 많이 쓰는것도 좋은 것은 아님

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/photo.dart';
import '../server.dart';
class PixabayApi {
  final baseUrl = 'https://pixabay.com/api/';

  Future<List<Photo>> fetch(String query) async {
    final response = await http.get(Uri.parse(
        "${baseUrl}?key=${key}&q=${query}&image_type=photo"));

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    Iterable hits = jsonResponse["hits"];
    return hits.map((e) => Photo.fromJson(e)).toList();
  }
}

