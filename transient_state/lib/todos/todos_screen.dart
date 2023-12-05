import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transient_state/todos/bloc/todos_bloc.dart';
import 'package:transient_state/utils/context_helper.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<TodosBloc>().add(LoadTodos());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (_, state) {
        return switch (state) {
          TodosLoading _ => const LoadingView(),
          TodosLoaded s => LoadedView(todos: s.todos),
          _ => const SizedBox(),
        };
      },
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class LoadedView extends StatelessWidget {
  final List<String> todos;

  const LoadedView({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.note_add),
        onPressed: () {
          final bloc = context.read<TodosBloc>();
          final event = AddTodo(Faker().lorem.sentence());
          bloc.add(event);
        },
      ),
      body: BlocListener<TodosBloc, TodosState>(
        listenWhen: (_, current) => current.isTransient,
        listener: (context, state) {
          try {
            context.showSnack((state as dynamic).message); // 😎
          } catch (_) {}
        },
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: todos.length,
          itemBuilder: (_, index) => Card(
            child: ListTile(
              title: Text(todos[index]),
              trailing: IconButton(
                onPressed: () {
                  final bloc = context.read<TodosBloc>();
                  final event = RemoveTodo(todos[index]);
                  bloc.add(event);
                },
                icon: const Icon(Icons.delete),
              ),
            ),
          ),
          separatorBuilder: (_, __) => const SizedBox(height: 8),
        ),
      ),
    );
  }
}
