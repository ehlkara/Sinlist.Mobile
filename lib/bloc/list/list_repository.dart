import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sinlist_app/core/bloc/base_repository.dart';
import 'package:sinlist_app/core/http/api_provider.dart';
import 'package:sinlist_app/core/http/api_response.dart';
import 'package:sinlist_app/core/http/api_result.dart';
import 'package:sinlist_app/core/http/network_exceptions.dart';
import 'package:sinlist_app/data/lists/todolist.dart';
import 'package:sinlist_app/data/lists/todolist_items.dart';

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
        response.add(Todolist(name: 'New List'));
        return ApiResult.success(data: response);
      }
      else
        throw new Exception(apiResponse.error);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<List<TodoListItems>>> getTodoListByItems(int todolistId) async {
    try {
      final json = await apiProvider.get(
          "Todos/get_todolist_items_by_id?todoListId=$todolistId");
      ApiResponse apiResponse = ApiResponse.fromJson(json);
      if (!apiResponse.hasError) {
        var response = List<TodoListItems>.from(apiResponse.result.map((x) => TodoListItems.fromJson(x)));
        return ApiResult.success(data: response);
      }
      else
        throw new Exception(apiResponse.error);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<bool>> deleteTodolistItem(int todolistItemId) async {
    try {
      final json = await apiProvider.delete(
          "Todos/delete_todolist_item?todoListItemId=$todolistItemId");
      ApiResponse apiResponse = ApiResponse.fromJson(json);
      if (!apiResponse.hasError) {
        return ApiResult.success(data: true);
      }
      else
        throw new Exception(apiResponse.error);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<TodoListItems>> updateTodolistItem(TodoListItems todoListItem) async {
    try {
      final json = await apiProvider.post(
          "Todos/update_todolist_item", data: todoListItem.toJson());
      ApiResponse apiResponse = ApiResponse.fromJson(json);
      if (!apiResponse.hasError) {
        var response = TodoListItems.fromJson(apiResponse.result);
        return ApiResult.success(data: response);
      }
      else
        throw new Exception(apiResponse.error);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<TodoListItems>> addTodolistItem(TodoListItems todoListItem) async {
    try {
      final json = await apiProvider.post(
          "Todos/add_todolist_item", data: todoListItem.toJson());
      ApiResponse apiResponse = ApiResponse.fromJson(json);
      if (!apiResponse.hasError) {
        var response = TodoListItems.fromJson(apiResponse.result);
        return ApiResult.success(data: response);
      }
      else
        throw new Exception(apiResponse.error);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Todolist>> getTodolistById(int todolistId) async {
    try {
      final json = await apiProvider.get(
          "Todos/get_todolist_by_id?todoListId=$todolistId");
      ApiResponse apiResponse = ApiResponse.fromJson(json);
      if (!apiResponse.hasError) {
        var response = Todolist.fromJson(apiResponse.result);
        return ApiResult.success(data: response);
      }
      else
        throw new Exception(apiResponse.error);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<bool>> deleteTodolist(int todolistId) async {
    try {
      final json = await apiProvider.delete(
          "Todos/delete_todolist?todoListId=$todolistId");
      ApiResponse apiResponse = ApiResponse.fromJson(json);
      if (!apiResponse.hasError) {
        return ApiResult.success(data: true);
      }
      else
        throw new Exception(apiResponse.error);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<bool>> updateTodolist(Todolist todolist) async {
    try {
      final json = await apiProvider.post(
          "Todos/update", data: todolist.toJson());
      ApiResponse apiResponse = ApiResponse.fromJson(json);
      if (!apiResponse.hasError) {
        return ApiResult.success(data: true);
      }
      else
        throw new Exception(apiResponse.error);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
  Future<ApiResult<Todolist>> addTodolist(Todolist todolist) async {
    try {
      final json = await apiProvider.post(
          "Todos/add", data: todolist.toJson());
      ApiResponse apiResponse = ApiResponse.fromJson(json);
      if (!apiResponse.hasError) {
        var response = Todolist.fromJson(apiResponse.result);
        return ApiResult.success(data: response);
      }
      else
        throw new Exception(apiResponse.error);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}