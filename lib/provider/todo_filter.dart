import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../models/todo_model.dart';

class TodoFilterState extends Equatable {
  final Filter filter;
  const TodoFilterState({
    required this.filter,
  });
  factory TodoFilterState.initial() {
    return const TodoFilterState(filter: Filter.all);
  }
  @override
  List<Object?> get props => [filter];
  @override
  bool get stringify => true;
  TodoFilterState copyWith({
    Filter? filter,
  }) {
    return TodoFilterState(
      filter: filter ?? this.filter,
    );
  }
}

class TodoFilter with ChangeNotifier {
  // ignore: prefer_final_fields
  TodoFilterState _state = TodoFilterState.initial();
  // ignore: non_constant_identifier_names
  TodoFilterState get State => _state;

  void changeFilter(Filter newFilter) {
    _state = _state.copyWith(filter: newFilter);
    notifyListeners();
  }
}
