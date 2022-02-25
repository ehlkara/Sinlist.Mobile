import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sinlist_app/core/bloc/base_repository.dart';
import 'package:sinlist_app/core/http/api_provider.dart';
import 'package:sinlist_app/core/http/api_response.dart';
import 'package:sinlist_app/core/http/api_result.dart';
import 'package:sinlist_app/core/http/network_exceptions.dart';
import 'package:sinlist_app/data/lists/todolist.dart';

class ListRepository implements BaseRepository {
  ListRepository({@required this.apiProvider});

  final ApiProvider apiProvider;
  final DateFormat formatter = DateFormat("yyyy-MM-dd", "tr");

  Future<ApiResult<List<Todolist>>> getTodoLists(String deviceInfo) async {
    try {
      final json = await apiProvider.get(
          "Todos/get_todolist?deviceInfo=$deviceInfo");
      ApiResponse apiResponse = ApiResponse.fromJson(json);
      if (!apiResponse.hasError) {
        var response = List<Todolist>.from(apiResponse.result.map((x) => Todolist.fromJson(x)));
        return ApiResult.success(data: response);
      }
      else
        throw new Exception(apiResponse.error);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}