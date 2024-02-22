import 'package:flutter/material.dart';
import 'package:lesson_network_homework/model/employee_model.dart';
import 'package:lesson_network_homework/service/http_service.dart';
import 'package:lesson_network_homework/service/log_service.dart';

class NetworkPage extends StatefulWidget {
  const NetworkPage({super.key});

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  @override
  void initState() {
    super.initState();
    var employee = Employee(id: 1,employee_age: "18",employee_Name: "Dadaxon",employee_image: "",employee_salary: "3200000");
    // _apiCreatePost(employee);
    // _apiUpdate(employee);
    _apiDelete(employee);
  }

  void _apiGetList(){
    Network.GET(Network.API_LIST, Network.paramsEmpty()).then((response) => {
      LogService.i(response.toString())
    });
  }
  void _apiGetSingle(Employee employee){
    Network.GET(Network.API_LIST_SINGLE + employee.id.toString(), Network.paramsEmpty()).then((response) => {
      LogService.d(response.toString())
    });
  }

  void _apiDelete(Employee employee){
    Network.DEL(Network.API_DELETE + employee.id.toString(), Network.paramsEmpty()).then((response) => {
      LogService.d(response.toString())
    });
  }
  void _apiCreatePost(Employee employee){
    Network.POST(Network.API_CREATE, Network.paramsCreate(employee)).then((response) => {
      LogService.i(response.toString())
    });
  }

  void _apiUpdate(Employee employee){
    Network.PUT(Network.API_UPDATE + employee.id.toString(), Network.paramsUpdate(employee)).then((response) => {LogService.w(response.toString())});
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(

    );
  }
}
