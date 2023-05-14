import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo/provider/todo_filter.dart';

import '../models/todo_model.dart';
import 'todo_list.dart';
import 'todo_search.dart';

class FilteredTodoState extends Equatable {
  final List<Todo> filterTodos;
  const FilteredTodoState({
    required this.filterTodos,
  });

  factory FilteredTodoState.initial() {
    return const FilteredTodoState(filterTodos: []);
  }

  @override
  bool get stringify => true;

  @override
  // TODO: implement props
  List<Object?> get props => [filterTodos];
  FilteredTodoState copyWith({
    List<Todo>? filterTodos,
  }) {
    return FilteredTodoState(
      filterTodos: filterTodos ?? this.filterTodos,
    );
  }
}

class FilteredTodos with ChangeNotifier {
  FilteredTodoState _state = FilteredTodoState.initial();
  FilteredTodoState get state => _state;

  void update(
    TodoFilter todoFilter,
    TodoSearch todoSearch,
    TodoList todoList,
  ) {
    List<Todo> _filteredTodos;
    switch (todoFilter.State.filter) {
      case Filter.active:
        _filteredTodos =
            todoList.State.todos.where((Todo todo) => !todo.completed).toList();
        break;
      case Filter.completed:
        _filteredTodos =
            todoList.State.todos.where((Todo todo) => todo.completed).toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todoList.State.todos;
        break;
    }
    if (todoSearch.State.searchTerm.isEmpty) {
      _filteredTodos = _filteredTodos
          .where((Todo todo) =>
              todo.desc.toLowerCase().contains(todoSearch.State.searchTerm))
          .toList();
    }
    _state = _state.copyWith(filterTodos: _filteredTodos);
    notifyListeners();
  }
}
