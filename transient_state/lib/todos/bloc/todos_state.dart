part of 'todos_bloc.dart';

abstract class TodosState extends Equatable {
  bool get isSteady;
  bool get isTransient => !isSteady;
}

class TodosLoading extends TodosState {
  @override
  bool get isSteady => true;

  @override
  List<Object?> get props => [];
}

class TodosLoaded extends TodosState {
  final List<String> todos;

  TodosLoaded(this.todos);

  @override
  bool get isSteady => true;

  @override
  List<Object?> get props => [todos];
}

class TodoAdded extends TodosState {
  final String todo;

  TodoAdded(this.todo);

  String get message => 'Todo "$todo" added';

  @override
  bool get isSteady => false;

  @override
  List<Object?> get props => [todo];
}

class TodoRemoved extends TodosState {
  final String todo;

  TodoRemoved(this.todo);

  String get message => 'Todo "$todo" removed';

  @override
  bool get isSteady => false;

  @override
  List<Object?> get props => [todo];
}
