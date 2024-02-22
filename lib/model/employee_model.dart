class Employee{
  int? id;
  String? employee_Name;
  String? employee_salary;
  String? employee_age;
  String? employee_image;

  Employee({this.id,this.employee_Name,this.employee_salary,this.employee_age,this.employee_image});

  Employee.fromJson(Map<String,dynamic> json){
    id = json['id'];
    employee_Name = json['name'];
    employee_salary = json['salary'];
    employee_age = json['age'];
    employee_image = json['image'];
  }
  Map<String,dynamic> toJson(){
    return {
      "id":id,
      "name":employee_Name,
      "salary":employee_salary,
      "image":employee_image,
    };
  }
}