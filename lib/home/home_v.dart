import 'package:bloc_test_project/home/home_m.dart';
import 'package:bloc_test_project/home/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TextButton(
                onPressed: () {
                  context.read<HomeViewModel>().add(
                        const HomeLoadEvent(
                          url: person1,
                          loader: getPersons,
                        ),
                      );
                },
                child: const Text('load json 1')),
            TextButton(
                onPressed: () {
                  context.read<HomeViewModel>().add(
                        const HomeLoadEvent(
                          url: person2,
                          loader: getPersons,
                        ),
                      );
                },
                child: const Text('load json 2')),
          ],
        ),
        BlocBuilder<HomeViewModel, HomeState?>(
          builder: (context, state) {
            if (state is HomeLoaded) {
              final list = state.persons.toList();
              return SizedBox(
                width: 200,
                height: 500,
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(list[index].name),
                      subtitle: Text(list[index].age.toString()),
                    );
                  },
                ),
              );
            }
            return const Text('is empty');
          },
        ),
      ],
    );
  }
}
