import 'dart:convert';
import 'dart:io';

import 'package:bloc_test_project/model/person.dart';

Future<List<Person>> getPerson(String uri) async {
  final req = await HttpClient()
      .getUrl(
        Uri.parse(uri),
      )
      .then(
        (req) => req.close(),
      )
      .then(
        (resp) => resp.transform(utf8.decoder).join(),
      )
      .then(
        (str) => json.decode(str) as List<dynamic>,
      )
      .then(
        (list) => list.map(
          (e) => Person.fromJson(e),
        ),
      );
  return req.toList();
}
