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
  bool isLoading = false;
  var items = [];
  @override
  void initState() {
    super.initState();
    _apiGetList();
  }

  void _apiGetList() async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      setState(() {
        isLoading = false;
        items = Network.parsePostList(response);
      });
    }
  }

  void _apiGetSingle(Employee employee) {
    Network.GET(Network.API_LIST_SINGLE + employee.id.toString(),
            Network.paramsEmpty())
        .then((response) => {LogService.d(response.toString())});
  }

  void _apiDelete(Employee employee) {
    Network.DEL(
            Network.API_DELETE + employee.id.toString(), Network.paramsEmpty())
        .then((response) => {LogService.d(response.toString())});
  }

  void _apiCreatePost(Employee employee) {
    Network.POST(Network.API_CREATE, Network.paramsCreate(employee))
        .then((response) => {LogService.i(response.toString())});
  }

  void _apiUpdate(Employee employee) {
    Network.PUT(Network.API_UPDATE + employee.id.toString(),
            Network.paramsUpdate(employee))
        .then((response) => {LogService.w(response.toString())});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Employees List",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(itemBuilder: (ctx, index) {
              return itemEmp(items[index]);
            }),
    );
  }

  Widget itemEmp(Employee employee) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            employee.employeeName.toString(),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const SizedBox(height: 10),
          Text(
            employee.employeeAge.toString(),
            style: const TextStyle(color: Colors.black, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
