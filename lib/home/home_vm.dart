import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_test_project/home/home_m.dart';
import 'package:bloc_test_project/models/person.dart';
import 'package:http/http.dart' as http;

enum PersonUrl { person1, person2 }

const person1 = "http://127.0.0.1:5500/lib/assets/person1.json";
const person2 = "http://127.0.0.1:5500/lib/assets/person2.json";

extension EnumUrlString on PersonUrl {
  String get urlString {
    switch (this) {
      case PersonUrl.person1:
        return person1;
      case PersonUrl.person2:
        return person2;
    }
  }
}

extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

typedef PersonLoader = Future<Iterable<Person>> Function(String url);

abstract class HomeEvent {}

class HomeLoadEvent implements HomeEvent {
  const HomeLoadEvent({
    required this.loader,
    required this.url,
  });

  final String url;
  final PersonLoader loader;
}

class HomeViewModel extends Bloc<HomeEvent, HomeState?> {
  HomeViewModel() : super(null) {
    on<HomeLoadEvent>((event, emit) async {
      final url = event.url;
      if (_cache.containsKey(url)) {
        emit(HomeLoaded(retrievedFromCache: true, persons: _cache[url]!));
      } else {
        final loader = event.loader;
        final persons = await loader(url);
        _cache[url] = persons;
        emit(HomeLoaded(retrievedFromCache: false, persons: persons));
      }
    });
  }
  final Map<String, Iterable<Person>> _cache = {};
}

Future<Iterable<Person>> getPersons(String uri) async {
  final persons = <Person>[];
  final result = await http.get(Uri.parse(uri));
  final josnList = jsonDecode(result.body.toString()) as List<dynamic>;
  for (var element in josnList) {
    persons.add(Person.fromJson(element));
  }
  return persons;
}
