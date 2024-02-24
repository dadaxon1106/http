import 'dart:convert';

import 'package:http/http.dart';
import 'package:lesson_network_homework/model/employee_model.dart';

class Network {
  static String BASE = "dummy.restapiexample.com";
  static Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  /* HTTPS APIS */

  static String API_LIST = "/api/v1/employees";
  static String API_LIST_SINGLE = "/api/v1/employee/"; // {id}
  static String API_CREATE = "/api/v1/create";
  static String API_UPDATE = "/api/v1/update/"; // {id}
  static String API_DELETE = "/api/v1/delete/"; // {id}

  /* HTTPS METHODS*/

  static Future<String?> DEL(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api, params);
    var response = await delete(uri, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api, params);
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    var uri = Uri.http(BASE, api);
    var response = await post(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api); // http or https
    var response = await put(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  /* HTTP PARAMS */
  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  static Map<String, String> paramsCreate(Employee employee) {
    Map<String, String> params = {};
    params.addAll({
      "employee_name": employee.employeeName,
      "employee_salary": employee.employeeSalary.toString(),
      "employee_age": employee.employeeAge.toString(),
      "profile_image": employee.profileImage
    });
    return params;
  }

  static Map<String, String> paramsUpdate(Employee employee) {
    Map<String, String> params = {};
    params.addAll({
      "id": employee.id.toString(),
      "employee_name": employee.employeeName,
      "employee_salary": employee.employeeSalary.toString(),
      "employee_age": employee.employeeAge.toString(),
      "profile_image": employee.profileImage
    });
    return params;
  }

  static List<Employees> parsePostList(String response) => List<Employees>.from(
      jsonDecode(response).map((x) => Employees.fromJson(x)));
}
