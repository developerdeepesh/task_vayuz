import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_vayuz/model/todo_model.dart';
import 'package:task_vayuz/view_model/todo_view_model.dart';
import 'package:task_vayuz/wdigets/empty_list.dart';

class TodoListScreen extends StatefulWidget {
  String isFrom;

  TodoListScreen({super.key, required this.isFrom});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<TodoViewModel>().getAllTodoItem(widget.isFrom);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0D3257),
        title: const Text('Todo List'),
        centerTitle: true,
      ),
      body: _getBody(),
    );
  }

  Widget _getBody() {
    return Consumer<TodoViewModel>(
      builder: (context, viewModel, child) {
        return viewModel.todoList!.isEmpty
            ? EmptyList()
            : Container(
                margin: const EdgeInsets.only(top: 20),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: Text(
                                  viewModel.todoList![index].title!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: Text(
                                  viewModel.todoList![index].description!,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: Text(
                                  viewModel.todoList![index].date!,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  viewModel.textTitleController.text =
                                      viewModel.todoList![index].title!;
                                  viewModel.textDesController.text =
                                      viewModel.todoList![index].description!;
                                  updateItem(
                                      viewModel, viewModel.todoList![index]);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  viewModel.deleteTodoItem(
                                      viewModel.todoList![index]);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: viewModel.todoList!.length,
                  separatorBuilder: (context, index) => const Divider(),
                ),
              );
      },
    );
  }

  void updateItem(TodoViewModel viewModel, TodoModel todoModel) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(0),
            elevation: 0.0,
            backgroundColor: Colors.white24,
            child: Container(
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
                          const SizedBox(height: 24.0),
                          Row(children: [
                            Expanded(
                              child: InkWell(
                                  onTap: () {
                                    viewModel.updateTodoItem(
                                        todoModel, widget.isFrom);
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
                                        "Update",
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
            ),
          );
        });
  }
}
