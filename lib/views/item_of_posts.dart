import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:patterns_provider/viewmodel/home_view_model.dart';

Widget itemOfPost(HomeViewModel homeViewModel, int index, BuildContext context) {
  return Card(
    child: Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            label: 'Delete',
            backgroundColor: Colors.red,
            onPressed: (_) {
              homeViewModel.apiPostDelete(homeViewModel.posts[index]).then((value) => {
                if(value) homeViewModel.apiPostList(),
              });
              homeViewModel.posts.removeAt(index);
            },
            icon: Icons.delete,
          ),
        ],
      ),
      startActionPane: ActionPane(
        dragDismissible: true,
        extentRatio: 0.3,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            label: "Edit",
            backgroundColor: Colors.blue,
            onPressed: (_) {
              homeViewModel.goToEdit(context,homeViewModel.posts[index]);
            },
            icon: Icons.edit,
          ),
        ],
      ),
      child: ListTile(
        title: Text(homeViewModel.posts[index].title!.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold),),
        subtitle: Text(homeViewModel.posts[index].body!),
      ),
    ),
  );
}