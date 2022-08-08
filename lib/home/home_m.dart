import 'package:bloc_test_project/models/person.dart';

extension IsEqualIgnotingOrder<T> on Iterable<T> {
  bool isEqualIgnoringOrder(Iterable<T> other) =>
      length == other.length &&
      {...this}.intersection({...other}).length == length;
}

class HomeState {}

class HomeLoaded extends HomeState {
  final Iterable<Person> persons;

  final bool retrievedFromCache;
  HomeLoaded({
    required this.retrievedFromCache,
    required this.persons,
  });

  @override
  String toString() {
    return "FetchedResult, retrieved from cache=$retrievedFromCache, persons=$persons";
  }

  @override
  bool operator ==(covariant HomeLoaded other) =>
      persons.isEqualIgnoringOrder(other.persons) &&
      retrievedFromCache == other.retrievedFromCache;

  @override
  int get hashCode => Object.hash(persons, retrievedFromCache);
}

class HomeError extends HomeState {}
