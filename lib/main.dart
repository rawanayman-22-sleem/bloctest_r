import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Model/PostModel.dart';
import 'View/PostScreen.dart';
import 'ViewModel/Bloc/Cubit/PostCubit.dart';
import 'ViewModel/Bloc/MyBlocObserver.dart';
import 'ViewModel/DataBase/Local/Shared_Helper.dart';
import 'ViewModel/DataBase/Network/Dio_Exceptions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedHelper.init();
  await DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>PostCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: PostScreen(),
      ),
    );
  }
}