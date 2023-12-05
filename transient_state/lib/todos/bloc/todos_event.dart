part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {}

class LoadTodos extends TodosEvent {
  @override
  List<Object?> get props => [];
}

class AddTodo extends TodosEvent {
  final String todo;

  AddTodo(this.todo);

  @override
  List<Object?> get props => [todo];
}

class RemoveTodo extends TodosEvent {
  final String todo;

  RemoveTodo(this.todo);

  @override
  List<Object?> get props => [todo];
}
