import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_test_project/home/home_m.dart';
import 'package:bloc_test_project/home/home_vm.dart';
import 'package:bloc_test_project/models/person.dart';
import 'package:flutter_test/flutter_test.dart';

const mockedPerson1 = [
  Person(name: '1', age: 12),
  Person(name: '2', age: 42),
];
const mockedPerson2 = [
  Person(name: '3', age: 32),
  Person(name: '4', age: 56),
];

Future<Iterable<Person>> getPerson1(String url) {
  return Future.value(mockedPerson1);
}

Future<Iterable<Person>> getPerson2(String url) {
  return Future.value(mockedPerson2);
}

void main() {
  group('Testing Bloc', () {
    late HomeViewModel homeBloc;
    setUp(() {
      homeBloc = HomeViewModel();
    });
    blocTest<HomeViewModel, HomeState?>(
      'Test initial state',
      build: () {
        return homeBloc;
      },
      verify: (bloc) => expect(bloc.state, null),
    );

    blocTest<HomeViewModel, HomeState?>(
      'mock retrieving person from first iterable',
      build: () => homeBloc,
      act: (bloc) {
        bloc.add(const HomeLoadEvent(loader: getPerson1, url: 'url'));
        bloc.add(const HomeLoadEvent(loader: getPerson1, url: 'url'));
      },
      expect: () => [
        HomeLoaded(retrievedFromCache: false, persons: mockedPerson1),
        HomeLoaded(retrievedFromCache: true, persons: mockedPerson1),
      ],
    );
    blocTest<HomeViewModel, HomeState?>(
      'mock retrieving persons2 from iterable',
      build: () => homeBloc,
      act: (bloc) {
        bloc.add(const HomeLoadEvent(loader: getPerson2, url: 'url'));
        bloc.add(const HomeLoadEvent(loader: getPerson2, url: 'url'));
      },
      expect: () => [
        HomeLoaded(retrievedFromCache: false, persons: mockedPerson2),
        HomeLoaded(retrievedFromCache: true, persons: mockedPerson2),
      ],
    );
  });
}
