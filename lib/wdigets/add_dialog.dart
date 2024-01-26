import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_vayuz/view_model/todo_view_model.dart';
class AddDialog  extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoViewModel>(builder: (context, viewModel, child) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        child: Center(
          child: Stack(
            children: [
              Container(
                margin:
                const EdgeInsets.only(top: 10, left: 40, right: 40),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20.0),
                    const Text(
                      "Add New Task",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff0D3257)),
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      child: TextField(
                        controller: viewModel.textTitleController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: "Enter Title"),
                        autofocus: true,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      child: TextField(
                        maxLines: 2,
                        controller: viewModel.textDesController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: "Enter Description"),
                        autofocus: true,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: () {
                        _selectDate(context, viewModel);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.grey)),
                        margin:
                        const EdgeInsets.only(left: 30, right: 30),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children:  [
                              const Icon(Icons.date_range),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                DateFormat('dd-MMM-yyyy').format(viewModel.selectedDate),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Row(children: [
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              viewModel.addItemOnDB();
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 90, right: 90),
                              decoration: const BoxDecoration(
                                color: Color(0xff0D3257),
                                //border: Border.all(width: 0.0, color: Colors.white),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20.0)),
                              ),
                              height: 45,
                              child: const Center(
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                            )),
                      ),
                    ]),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
              Positioned(
                  right: 50,
                  top: 20,
                  child: GestureDetector(
                      onTap: () {
                        viewModel.textTitleController.clear();
                        viewModel.textDesController.clear();
                        viewModel.selectedDate = DateTime.now();
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.clear,
                        color: Colors.black,
                        size: 25,
                      ))),
            ],
          ),
        ),
      );
    },);
  }

  Future<void> _selectDate(
      BuildContext context, TodoViewModel viewModel) async {
    final DateTime? picked = await showDatePicker(
        builder: (context,child){
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(primary: Color(0xff0D3257)),
              buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary
              ),
            ), child: child!,
          );
        },

        context: context,
        initialDate: viewModel.selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101)

    );
    if (picked != null && picked != viewModel.selectedDate) {
      viewModel.updateSelectDated(picked);
    }
  }
}
