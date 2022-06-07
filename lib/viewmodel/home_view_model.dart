import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:patterns_provider/models/post_model.dart';
import 'package:patterns_provider/pages/create_page.dart';
import 'package:patterns_provider/pages/update_page.dart';
import 'package:patterns_provider/services/http_service.dart';

class HomeViewModel extends ChangeNotifier{
  List <Post> posts = [];
  bool isLoading = false;

  Future apiPostList() async{
    isLoading = true;
    notifyListeners();
    Network.GET(Network.API_LIST, Network.paramsEmpty()).then((response) => {
      showResponse(response!),
    });
  }
  Future<bool> apiPostDelete(Post post) async{

    var response  = Network.DEL(Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    isLoading = false;
    notifyListeners();
    return (response != null);
  }

  void showResponse(String response) {
    List json = jsonDecode(response);
    posts = List<Post>.from(json.map((x) => Post.fromJson(x)));
    isLoading = false;
    notifyListeners();
  }

  void goToCreate(BuildContext context) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CreatePage()));
    if (result != null) {
      posts.add(result as Post);
      apiPostList();
    }
  }

  void goToEdit(BuildContext context, Post post) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UpdatePage(
              post: post,
            )));
    if (result != null) {
      posts
          .replaceRange(posts.indexOf(post), posts.indexOf(post) + 1, [result]);
      apiPostList();
    }
  }
}