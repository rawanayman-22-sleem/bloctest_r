import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Model/PostModel.dart';
import '../../DataBase/Network/Dio_Exceptions.dart';
import '../../DataBase/Network/End_Points.dart';
import 'PostsTate.dart';

class PostCubit extends Cubit<PostsState> {
  PostCubit() : super(PostsInitial());

  List<PostModel> postModel = [];

  static PostCubit get(context) => BlocProvider.of(context);

  void getpost() {
    emit(PostsLoading());
    DioHelper.getData(url: baseUrl + posts).then((value) {
      print(value);
      for (var i in value.data) {
        postModel.add(PostModel.fromJson(i));
      }

      emit(PostsSuccess());
    }).catchError((onError){
      print(onError);
      emit(PostsError());

    });
  }
}
