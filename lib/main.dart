import 'package:bloc_test_project/assets/person_asset.dart';
import 'package:bloc_test_project/helper/api.dart';
import 'package:bloc_test_project/model/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test_project/helper/extensions.dart';

void main() {
  runApp(
    MaterialApp(
      home: BlocProvider(
        create: (context) => PersonBloc(),
        child: Scaffold(
          appBar: AppBar(),
          body: const Home(),
        ),
      ),
    ),
  );
}

abstract class LoadAction {
  const LoadAction();
}

class UrlLoadAction implements LoadAction {
  final PersonUrl url;

  const UrlLoadAction(this.url);
}

class FetchedPersonState {
  final Iterable<Person> persons;
  final bool isRetrievedFromCached;

  FetchedPersonState({
    required this.persons,
    required this.isRetrievedFromCached,
  });

  @override
  String toString() => 'FetchResult $isRetrievedFromCached - $persons';
}

class PersonBloc extends Bloc<LoadAction, FetchedPersonState?> {
  PersonBloc() : super(null) {
    on<UrlLoadAction>((event, emit) async {
      final url = event.url;
      if (_cached.containsKey(url)) {
        final cachedPerson = _cached[url]!;
        final result = FetchedPersonState(
          persons: cachedPerson,
          isRetrievedFromCached: true,
        );
        emit(result);
      } else {
        final persons = await getPerson(url.urlString);
        _cached[url] = persons;
        final result = FetchedPersonState(
          persons: persons,
          isRetrievedFromCached: true,
        );
        emit(result);
      }
    });
  }

  final Map<PersonUrl, Iterable<Person>> _cached = {};
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TextButton(
              onPressed: () {
                context.read<PersonBloc>().add(
                      const UrlLoadAction(
                        PersonUrl.personUrl1,
                      ),
                    );
              },
              child: const Text('Load Json 1'),
            ),
            TextButton(
              onPressed: () {
                context.read<PersonBloc>().add(
                      const UrlLoadAction(
                        PersonUrl.personUrl2,
                      ),
                    );
              },
              child: const Text('Load Json 2'),
            ),
          ],
        ),
        BlocBuilder<PersonBloc, FetchedPersonState?>(
          buildWhen: (previousResult, currentResult) {
            return previousResult?.persons != currentResult?.persons;
          },
          builder: (context, fetchResult) {
            final persons = fetchResult?.persons;
            if (persons == null) {
              return Container();
            } else {
              return Expanded(
                child: ListView.builder(
                    itemCount: persons.length,
                    itemBuilder: (_, index) {
                      final person = persons[index]!;
                      return ListTile(
                        title: Text(person.name),
                      );
                    }),
              );
            }
          },
        )
      ],
    );
  }
}
