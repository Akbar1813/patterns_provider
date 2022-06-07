import 'package:flutter/material.dart';
import 'package:patterns_provider/viewmodel/home_view_model.dart';
import 'package:patterns_provider/views/item_of_posts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {

  static const String id = "home_page";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeViewModel homeViewModel = HomeViewModel();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeViewModel.apiPostList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider"),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (context) => homeViewModel,
        child: Consumer<HomeViewModel>(
          builder: (ctx, model, index) => Stack(
            children: [
              ListView.builder(
                itemCount: homeViewModel.posts.length,
                itemBuilder: (BuildContext context, int index){
                  return itemOfPost(homeViewModel, index,context);
                },
              ),
              homeViewModel.isLoading
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : Container(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){homeViewModel.goToCreate(context);},
        child: const Icon(Icons.add),
      ),
    );
  }
}
