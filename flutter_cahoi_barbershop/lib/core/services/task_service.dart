import 'package:dio/src/form_data.dart';
import 'package:flutter_cahoi_barbershop/core/apis/api.dart';
import 'package:flutter_cahoi_barbershop/core/models/task.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';

class TaskService {
  final _api = locator<Api>();

  Future<bool> updateTaskStatus({required FormData data}) async {
    // Map<String, dynamic> data = {};
    var res = await _api.updateTaskStatus(data: data);

    if (res != null) {
      return res.data;
    }

    return false;
  }

  Future<Task?> getDetailTask({required int taskId}) async {
    var res = await _api.getDetailTask(data: {"task_id": taskId});

    if (res != null && res.data != null) {
      return Task.fromJson(res.data);
    }

    return null;
  }

  Future<List<Task>> searchTask(String? searchString,
      {required int page}) async {
    Map<String, dynamic> data = {
      "page": page,
    };
    if (searchString != null && searchString.isNotEmpty) {
      data.addAll({"search_string": searchString});
    }

    var res = await _api.searchTask(data: data);

    if (res != null) {
      return List<Task>.from(
        res.data.map((e) => Task.fromJson(e)).toList(),
      );
    }

    return [];
  }
}