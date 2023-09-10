import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/providers/file_upload_provider.dart';
import 'package:hire_pro/providers/task_provider.dart';
import 'package:provider/provider.dart';

class UploadImageBox extends StatelessWidget {
  final String placeholder;
  UploadImageBox(this.placeholder);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
        builder: (context, taskData, child) => Center(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (taskData.files.isEmpty)
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.cloud_upload_outlined, size: 40),
                            color: Colors.grey,
                            onPressed: () {
                              taskData.openFiles();
                            },
                          ),
                          Text(placeholder,
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    SizedBox(height: 10), // Add some spacing
                    if (taskData.files.isNotEmpty) // Display selected images
                      Container(
                        height: 150,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Expanded(
                              child: GridView.count(
                                crossAxisCount: 3,
                                children: taskData.files.map((file) {
                                  return Card(
                                    color: kMainGrey,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Image.file(
                                        file,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ));
  }
}
