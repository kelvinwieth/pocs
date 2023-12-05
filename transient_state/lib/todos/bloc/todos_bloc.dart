import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:faker/faker.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  static const _delay = Duration(milliseconds: 300);
  final _todos = [
    Faker().lorem.sentence(),
    Faker().lorem.sentence(),
    Faker().lorem.sentence(),
  ];

  TodosBloc() : super(TodosLoading()) {
    on<LoadTodos>(onLoad);
    on<AddTodo>(onAdd);
    on<RemoveTodo>(onRemove);
  }

  void onLoad(LoadTodos event, Emitter<TodosState> emit) async {
    emit(TodosLoading());
    await Future.delayed(_delay);
    emit(TodosLoaded(_todos.toList()));
  }

  void onAdd(AddTodo event, Emitter<TodosState> emit) async {
    await Future.delayed(_delay);
    _todos.add(event.todo);
    emit(TodoAdded(event.todo));
    emit(TodosLoaded(_todos.toList()));
  }

  void onRemove(RemoveTodo event, Emitter<TodosState> emit) async {
    await Future.delayed(_delay);
    _todos.remove(event.todo);
    emit(TodoRemoved(event.todo));
    emit(TodosLoaded(_todos.toList()));
  }
}
