import 'package:flutter/material.dart';
import 'package:patterns_provider/models/post_model.dart';
import 'package:patterns_provider/services/http_service.dart';

class UpdateView extends ChangeNotifier {
  late Post post;
  bool isLoading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  void saveAndExit(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    String title = titleController.text.toString().trim();
    String body = bodyController.text.toString().trim();
    Post postUpdate =
    Post(id: post.id, title: title, body: body, userId: post.userId);
    await Network.PUT(Network.API_UPDATE + postUpdate.id.toString(),
        Network.paramsUpdate(postUpdate));
    Navigator.pop((context), postUpdate);
    isLoading = false;
    notifyListeners();
  }
}