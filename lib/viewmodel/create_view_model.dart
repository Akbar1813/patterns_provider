import 'package:flutter/material.dart';
import 'package:patterns_provider/models/post_model.dart';
import 'package:patterns_provider/services/http_service.dart';

class CreateView extends ChangeNotifier {
  bool isLoading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  void saveAndExit(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    String title = titleController.text.toString().trim();
    String body = bodyController.text.toString().trim();
    Post postCreate = Post(title: title, body: body, userId: title.hashCode);
    await Network.POST(Network.API_CREATE, Network.paramsCreate(postCreate));
    Navigator.pop((context), postCreate);
    isLoading = false;
    notifyListeners();
  }
}