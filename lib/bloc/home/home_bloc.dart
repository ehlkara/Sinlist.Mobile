import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinlist_app/bloc/list/list_repository.dart';
import 'package:sinlist_app/core/bloc/result_state.dart';
import 'package:sinlist_app/core/http/api_result.dart';
import 'package:sinlist_app/core/http/network_exceptions.dart';
import 'package:sinlist_app/data/lists/todolist.dart';

class HomeBloc extends Cubit<ResultState<List<Todolist>>> {
  HomeBloc({this.repository})
      : assert(repository != null),
        super(Idle());

  final ListRepository repository;

  getTodolists(String deviceInfo) async {
    emit(ResultState.loading());
    ApiResult<List<Todolist>> apiResult = await repository.getTodoLists(deviceInfo);
    apiResult.when(
      success: (List<Todolist> data) => emit(ResultState.data(data: data)),
      failure: (NetworkExceptions error) => emit(ResultState.error(error: error)),
    );
  }
}
