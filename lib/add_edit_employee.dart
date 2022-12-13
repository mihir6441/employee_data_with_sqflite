import 'package:employee_data_with_sqflite/database_helper.dart';
import 'package:employee_data_with_sqflite/employee.dart';
import 'package:employee_data_with_sqflite/employees_list.dart';
import 'package:flutter/material.dart';

class AddEditEmployee extends StatefulWidget {
  bool isEdit;
  Employee? selectedEmployee;

  AddEditEmployee(this.isEdit, [this.selectedEmployee]);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddEditEmployeeState();
  }
}

class AddEditEmployeeState extends State<AddEditEmployee> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerSalary = TextEditingController();
  TextEditingController controllerAge = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if (widget.isEdit) {
      controllerName.text = widget.selectedEmployee!.empName!;
      controllerSalary.text = widget.selectedEmployee!.empSalary.toString();
      controllerAge.text = widget.selectedEmployee!.empAge.toString();
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text("Employee Name:", style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextField(controller: controllerName),
                    )
                  ],
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text("Employee Salary:", style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                          controller: controllerSalary,
                          keyboardType: TextInputType.number),
                    )
                  ],
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text("Employee Age:", style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                          controller: controllerAge,
                          keyboardType: TextInputType.number),
                    )
                  ],
                ),
                const SizedBox(height: 100),
                ElevatedButton(
                  child: const Text("Submit",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  onPressed: () {
                    var getEmpName = controllerName.text;
                    var getEmpSalary = controllerSalary.text;
                    var getEmpAge = controllerAge.text;
                    if (getEmpName.isNotEmpty &&
                        getEmpSalary.isNotEmpty &&
                        getEmpAge.isNotEmpty) {
                      if (widget.isEdit) {
                        Employee updateEmployee = Employee(
                            empId: widget.selectedEmployee!.empId,
                            empName: getEmpName,
                            empSalary: getEmpSalary,
                            empAge: getEmpAge);
                        DatabaseHelper.instance.update(updateEmployee.toMap());
                      } else {
                        Employee addEmployee = Employee(
                            empName: getEmpName,
                            empSalary: getEmpSalary,
                            empAge: getEmpAge);
                        DatabaseHelper.instance
                            .insert(addEmployee.toMapWithoutId());
                      }
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => EmployeesList()),
                              (r) => false);
                    }
                  },
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
