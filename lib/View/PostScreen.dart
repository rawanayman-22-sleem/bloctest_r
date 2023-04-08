import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../ViewModel/Bloc/Cubit/PostCubit.dart';
import '../../ViewModel/Bloc/Cubit/PostsTate.dart';


class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCubit()..getpost(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Postes"),
          centerTitle: true,
        ),
        body: BlocBuilder<PostCubit, PostsState>(
          builder: (context, state) {
            PostCubit postCubit = PostCubit.get(context);
            print("state-----${state.runtimeType}");
            print("state-----${state.toString()}");
            return (state.runtimeType.toString()=="PostsLoading")
                ? Center(child: CircularProgressIndicator())
                :(state.runtimeType.toString()=="PostsError")?Center(child: Text("معلشششششششششششش(^-^)....")) :ListView.separated(
                itemBuilder: (context, index) {
                  return Text("${postCubit.postModel[index].title}");  },
                 separatorBuilder: (context, index) {
                   return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text("****Rw2n****"),
                  ); },
                itemCount: postCubit.postModel.length);
          },
        ),
      ),
    );
  }
}